class AddPointToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :lat, :double
    add_column :facilities, :lng, :double
  end
end
