class AddLocationsToShipment < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :start_location, :string
    add_column :shipments, :end_location, :string
  end
end
