class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :middle_name

      t.timestamps
    end

    create_table :doctor_patient_relationships do |t|
      t.belongs_to :doctor
      t.belongs_to :patient
      t.date  :start_date
      t.date  :end_date
      
      t.timestamps
    end
  end
end
