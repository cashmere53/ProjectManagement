class CreateAdvertisings < ActiveRecord::Migration
  def change
    create_table :advertisings do |t|
      t.string :advertise_info
      t.binary :image, limit: 10.megabyte
      t.date :contract_date
      t.references :inc_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
