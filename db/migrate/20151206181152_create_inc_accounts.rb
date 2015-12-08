class CreateIncAccounts < ActiveRecord::Migration
  def change
    create_table :inc_accounts do |t|
      t.string :inc_name
      t.string :password_digest
      t.string :mail_address
      t.string :phone_num
      t.string :account_name

      t.timestamps null: false
    end
  end
end
