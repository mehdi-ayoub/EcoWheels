class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.string :city
      t.float :distance_traveled
      t.string :vehicle_type
      t.string :fuel_type
      t.float :fuel_consumption
      t.string :product_name
      t.date :shipment_start
      t.date :shipment_end
      t.float :co2_emissions
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
