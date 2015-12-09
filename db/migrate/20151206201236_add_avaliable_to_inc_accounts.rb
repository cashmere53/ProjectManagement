class AddAvaliableToIncAccounts < ActiveRecord::Migration
  def change
    add_column :inc_accounts, :avaliable, :boolean
  end
end
