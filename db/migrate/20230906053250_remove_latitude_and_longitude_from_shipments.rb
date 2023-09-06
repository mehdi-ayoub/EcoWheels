class RemoveLatitudeAndLongitudeFromShipments < ActiveRecord::Migration[7.0]
  def change
    remove_column :shipments, :latitude, :float
    remove_column :shipments, :longitude, :float
  end
end
