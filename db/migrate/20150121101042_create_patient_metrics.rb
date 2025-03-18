class CreatePatientMetrics < ActiveRecord::Migration
  def change
    create_table :patient_metrics do |t|
      t.references :patient, index: true
      t.string :name
      t.string :value
      t.decimal :numeric_value
      t.string :unit
      t.datetime :taken_at

      t.timestamps null: false
    end
    add_foreign_key :patient_metrics, :patients
  end
end
