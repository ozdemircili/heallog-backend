class AddGuestToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :guest, :boolean, default: false
  end
end
