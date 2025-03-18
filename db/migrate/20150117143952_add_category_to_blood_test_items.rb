class AddCategoryToBloodTestItems < ActiveRecord::Migration
  def change
    add_column :blood_test_items, :category, :string
  end
end
