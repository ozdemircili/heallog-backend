class AddComplexValueToPatientMetrics < ActiveRecord::Migration
  def change
    add_column :patient_metrics, :complex_value, :json
  end
end
