class AddAvaliableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avaliable, :boolean
  end
end
