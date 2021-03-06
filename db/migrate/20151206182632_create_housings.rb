class CreateHousings < ActiveRecord::Migration
  def change
    create_table :housings do |t|
      t.string :street_address
      t.integer :rent
      t.integer :administration_cost
      t.string :housing_type
      t.date :building_date
      t.string :direction
      t.string :layout
      t.integer :area
      t.string :structure
      t.integer :floor
      t.integer :deposit
      t.integer :recompense
      t.integer :security_money
      t.integer :shikibiki
      t.integer :insurance
      t.integer :parking
      t.string :trading_aspect
      t.integer :another_cost
      t.string :vacancy
      t.string :detail
      t.integer :plan
      t.date :contract_update
      t.integer :views
      t.integer :favorites
      t.binary :image, limit: 10.megabyte
      t.references :inc_account, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
