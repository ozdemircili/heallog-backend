class AddDeviseTwoFactorToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :encrypted_otp_secret, :string
    add_column :doctors, :encrypted_otp_secret_iv, :string
    add_column :doctors, :encrypted_otp_secret_salt, :string
    add_column :doctors, :otp_required_for_login, :boolean
  end
end
