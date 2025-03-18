class AddPhoneNumberToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :phone_number, :string
  end
end
