class CreateBloodTestAssets < ActiveRecord::Migration
  def change
    create_table :blood_test_assets do |t|
      t.references :blood_test, index: true
      t.attachment :asset

      t.timestamps null: false
    end
    add_foreign_key :blood_test_assets, :blood_tests
  end
end
