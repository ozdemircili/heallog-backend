class Patient < ActiveRecord::Base
  include Omniauthable
  include TwoFactorAuthenticable
  include ActionView::Helpers::DateHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :two_factor_backupable,
         otp_secret_encryption_key: ENV['OTP_SECRET']


  has_many :doctor_patient_relationships, -> { where status: :accepted}
  has_many :doctors, through: :doctor_patient_relationships
  has_many :emergencies
  has_many :conditions
  has_many :metrics, class_name: "PatientMetric"
  has_many :annotations, through: :metrics

  validates :first_name, :last_name, presence: true

  attr_reader :current_weight, :current_height, :age_in_months, :age_in_words

  def send_otp
    if otp_required_for_login
      self.otp_secret = Patient.generate_otp_secret
      self.save!
      nexmo = Nexmo::Client.new(key: '86638881', secret: 'c246ef18')
      nexmo.send_message(from: "HealLog", to: phone_number, text: "Hello, here is your otp code: #{current_otp}")
    end
  end

  def has_humanapi_identity?
    not self.humanapi_identity.nil?
  end

  def humanapi_identity
    self.identities.where(provider: :humanapi).first
  end

  def current_height
    metric = self.metrics.where(name: :height).last
    return 0 if metric.nil?
    return metric.numeric_value.round(2)
  end

  def current_weight
    metric = self.metrics.where(name: :weight).last
    return 0 if metric.nil?
    return metric.numeric_value.round(2)
  end

  def current_blood_pressure
    metricS = self.metrics.where(name: :blood_pressure_systolic).last
    metricD = self.metrics.where(name: :blood_pressure_diastolic).last
    return [0, 0] if metricS.nil? or metricD.nil?
    return [metricD.numeric_value.round(2), metricS.numeric_value.round(2)]
  end
  
  def current_blood_oxygen
    metric = self.metrics.where(name: :blood_oxygen).last
    return 0 if metric.nil?
    return metric.numeric_value.round(2)
  end

  def current_heart_rate
    metric = self.metrics.where(name: :heart_rate).last
    return 0 if metric.nil?
    return metric.numeric_value.round(2)
  end

  def age_in_months
    return if self.birth_date.nil?
    (Time.now.year * 12 + Time.now.month) - (self.birth_date.year * 12 + self.birth_date.month)
  end

  def age_in_words
    return if self.birth_date.nil?
    distance_of_time_in_words(self.birth_date, Time.now)
  end

  def fetch_all_blood_pressures
    res = Humanapi::Human.all_blood_pressures(self.humanapi_identity.token)
    JSON.parse(res.body).each do |m|
      self.metrics.create({name: :blood_pressure_systolic, numeric_value: m["systolic"],
                           unit: m["unit"], taken_at: m["timestamp"],
                           hidentifier: "#{m["id"]}_systolic", source: m["source"]
      })
      self.metrics.create({name: :blood_pressure_diastolic, numeric_value: m["diastolic"],
                           unit: m["unit"], taken_at: m["timestamp"],
                           hidentifier: "#{m["id"]}_diastolic", source: m["source"]
      })
      self.metrics.create({name: :heart_rate, numeric_value: m["heartRate"],
                           unit: "bps", taken_at: m["timestamp"],
                           hidentifier: "#{m["id"]}_heart_rate", source: m["source"]
      })
    end
  end

  def fetch_all_blood_oxygen
    res = Humanapi::Human.all_blood_oxygen(self.humanapi_identity.token)
    JSON.parse(res.body).each do |m|
      self.metrics.create({name: :blood_oxygen, numeric_value: m["value"],
                           unit: m["unit"], taken_at: m["timestamp"],
                           hidentifier: m["id"], source: m["source"]
      })
    end
  end
  
  def fetch_all_activities
    res = Humanapi::Human.all_activities(self.humanapi_identity.token)
    JSON.parse(res.body).each do |m|
      self.metrics.create({name: :running, complex_value: {
                              duration: { value: m["duration"], unit: "s" },
                              distance: { value: m["distance"], unit: "m" },
                              steps: { value: m["steps"], unit: "steps"},
                              calories: { value: m["calories"], unit: "cal"}
                            },
                           taken_at: m["startTime"],
                           hidentifier: m["id"], source: m["source"]
      })
    end
  end


  def self.register_humanapi_metric(notification)
    patient = Identity.find_by_uid(notification["humanId"]).omniauthable
    case notification["type"]
    when "blood_pressure"
      res = Humanapi::Human.blood_pressure(notification["objectId"], self.humanapi_identity.token)
      m = JSON.parse(res.body)
      patient.metrics.create({name: :blood_pressure_systolic, numeric_value: m["systolic"],
                           unit: m["unit"], taken_at: m["timestamp"],
                           hidentifier: "#{notification["objectId"]}_systolic", source: m["source"]
      })
      patient.metrics.create({name: :blood_pressure_diastolic, numeric_value: m["diastolic"],
                           unit: m["unit"], taken_at: m["timestamp"],
                           hidentifier: "#{notification["objectId"]}_diastolic", source: m["source"]
      })
      patient.metrics.create({name: :heart_rate, numeric_value: m["heartRate"],
                           unit: "bps", taken_at: m["timestamp"],
                           hidentifier: "#{notification["objectId"]}_heart_rate", source: m["source"]
      })
    when "blood_oxygen"
      res = Humanapi::Human.all_blood_oxygen(notification["objectId"], self.humanapi_identity.token)
      m = JSON.parse(res.body)
      patient.metrics.create({name: :blood_oxygen, numeric_value: m["value"],
                              unit: m["unit"], taken_at: m["timestamp"],
                              hidentifier: m["id"], source: m["source"]
      })
    when "activitysummary"
      patient.fetch_all_activities
    end
  rescue
  end
end
