class AddProcessingStateToBloodTests < ActiveRecord::Migration
  def change
    add_column :blood_tests, :processing_state, :string
  end
end
