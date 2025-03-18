class AddPublicTokenToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :public_token, :string
  end
end
