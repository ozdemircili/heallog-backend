class AddDeviseTwoFactorToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :encrypted_otp_secret, :string
    add_column :patients, :encrypted_otp_secret_iv, :string
    add_column :patients, :encrypted_otp_secret_salt, :string
    add_column :patients, :otp_required_for_login, :boolean
  end
end
