class ChartAnnotationSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :taken_at, :status, :doctor

  def taken_at
    object.patient_metric.taken_at
  end
end
