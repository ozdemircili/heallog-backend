class CreateBloodTestItems < ActiveRecord::Migration
  def change
    create_table :blood_test_items do |t|
      t.references :blood_test, index: true
      t.string :name
      t.decimal :value
      t.string :unit
      t.string :test_identifier
      t.integer :connected_to_id
      t.decimal :min
      t.decimal :max
      t.decimal :avg

      t.timestamps null: false
    end
    add_foreign_key :blood_test_items, :blood_tests
  end
end
