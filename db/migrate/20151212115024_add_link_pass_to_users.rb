class AddLinkPassToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_pass, :string
  end
end
