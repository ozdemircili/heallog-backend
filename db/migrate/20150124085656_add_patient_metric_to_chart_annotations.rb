class AddPatientMetricToChartAnnotations < ActiveRecord::Migration
  def change
    add_reference :chart_annotations, :patient_metric, index: true
    add_foreign_key :chart_annotations, :patient_metrics
  end
end
