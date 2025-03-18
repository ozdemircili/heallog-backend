class AddFieldsToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :martial_status, :string
    add_column :patients, :sex, :string
    add_column :patients, :birth_date, :date
    add_column :patients, :profession, :string
    add_column :patients, :nationality, :string
    add_column :patients, :ssn, :string
    add_column :patients, :personal_id_code, :string
  end
end
