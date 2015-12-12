class AddLinkPassIncToIncAccounts < ActiveRecord::Migration
  def change
    add_column :inc_accounts, :link_pass, :string
  end
end
