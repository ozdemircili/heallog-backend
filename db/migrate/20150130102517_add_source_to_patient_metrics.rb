class AddSourceToPatientMetrics < ActiveRecord::Migration
  def change
    add_column :patient_metrics, :source, :string
  end
end
