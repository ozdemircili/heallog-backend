class Doctor < ActiveRecord::Base
  include Omniauthable
  include TwoFactorAuthenticable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :two_factor_backupable,
         otp_secret_encryption_key: ENV['OTP_SECRET']

  has_many :doctor_patient_relationships, -> { where status: :accepted}
  has_many :patients, through: :doctor_patient_relationships
  has_many :emergencies, through: :patients
  has_many :metrics, through: :patients
  has_many :annotations, through: :metrics
  belongs_to :istitution
  
  attr_reader :full_name

  def full_name
    [first_name, middle_name, last_name].join(" ")
  end
end
