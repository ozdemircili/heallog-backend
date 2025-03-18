class AddOtpBackupCodesToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :otp_backup_codes, :string, array: true
  end
end
