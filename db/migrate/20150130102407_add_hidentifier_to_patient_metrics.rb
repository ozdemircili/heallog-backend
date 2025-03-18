class AddHidentifierToPatientMetrics < ActiveRecord::Migration
  def change
    add_column :patient_metrics, :hidentifier, :string
    add_index :patient_metrics, :hidentifier
  end
end
