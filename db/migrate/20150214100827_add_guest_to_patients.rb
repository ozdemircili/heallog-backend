class AddGuestToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :guest, :boolean, default: false
  end
end
