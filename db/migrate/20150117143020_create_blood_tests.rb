class CreateBloodTests < ActiveRecord::Migration
  def change
    create_table :blood_tests do |t|
      t.references :patient, index: true
      t.string :performed_by
      t.datetime :taken_at

      t.timestamps null: false
    end
    add_foreign_key :blood_tests, :patients
  end
end
