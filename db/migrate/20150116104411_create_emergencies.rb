class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.references :patient, index: true
      t.string :description
      t.string :status
      t.integer :level

      t.timestamps null: false
    end
    add_foreign_key :emergencies, :patients
  end
end
