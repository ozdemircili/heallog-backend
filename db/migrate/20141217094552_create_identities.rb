class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.references :omniauthable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
