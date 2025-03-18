class PatientMetric < ActiveRecord::Base
  validates :name, :taken_at, presence: true
  belongs_to :patient
  default_scope {order(taken_at: :asc) }

  has_many :annotations, class_name: "ChartAnnotation"
end
