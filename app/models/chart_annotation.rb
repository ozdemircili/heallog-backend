class ChartAnnotation < ActiveRecord::Base
  self.inheritance_column = '_type'

  belongs_to :patient_metric
  belongs_to :doctor
end
