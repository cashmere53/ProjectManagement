class AddContentTypeToAdvertising < ActiveRecord::Migration
  def change
    add_column :advertisings, :content_type, :string
  end
end
