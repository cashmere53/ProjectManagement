class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true, foreign_key: true
      t.references :inc_account, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true
      t.references :housing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
