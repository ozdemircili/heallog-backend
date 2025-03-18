class CreateIstitutions < ActiveRecord::Migration
  def change
    create_table :istitutions do |t|
      t.string :name

      t.timestamps
    end
  end
end
