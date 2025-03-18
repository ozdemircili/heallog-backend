class AddOtpBackupCodesToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :otp_backup_codes, :string, array: true
  end
end
