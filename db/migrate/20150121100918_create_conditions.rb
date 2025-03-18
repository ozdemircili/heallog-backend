class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.references :patient, index: true
      t.string :name
      t.date :started_at
      t.date :ended_at
      t.boolean :cronic, default: false

      t.timestamps null: false
    end
    add_foreign_key :conditions, :patients
  end
end
