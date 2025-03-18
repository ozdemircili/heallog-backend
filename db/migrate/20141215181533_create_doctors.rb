class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.references :istitution, index: true

      t.timestamps
    end
  end
end
