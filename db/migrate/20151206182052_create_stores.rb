class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :store_name
      t.string :street_address
      t.string :postal_code
      t.references :inc_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
