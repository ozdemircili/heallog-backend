class ChangeTokenTypeInIdentities < ActiveRecord::Migration
  def change
    change_column :identities, :token, :text
  end
end
