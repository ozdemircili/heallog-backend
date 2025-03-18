class PatientMetricSerializer < ActiveModel::Serializer
  attributes :id, :value, :unit, :taken_at

  has_many :annotations
  def value
    object.numeric_value || object.value
  end
end
