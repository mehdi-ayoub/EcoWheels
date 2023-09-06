class AddGeocodingToShipments < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :start_latitude, :float
    add_column :shipments, :start_longitude, :float
    add_column :shipments, :end_latitude, :float
    add_column :shipments, :end_longitude, :float
  end
end
