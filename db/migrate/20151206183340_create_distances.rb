class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.integer :distance
      t.references :facility, index: true, foreign_key: true
      t.references :housing, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true
      t.references :inc_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
