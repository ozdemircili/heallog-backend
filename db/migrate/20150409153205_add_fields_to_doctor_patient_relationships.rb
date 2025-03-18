class AddFieldsToDoctorPatientRelationships < ActiveRecord::Migration
  def change
    add_column :doctor_patient_relationships, :status, :string, default: :pending
    add_column :doctor_patient_relationships, :token, :string
  end
end
