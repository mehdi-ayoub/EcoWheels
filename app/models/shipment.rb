class Shipment < ApplicationRecord
  belongs_to :user

  validates_presence_of :city,
                        :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
                        :product_name, :shipment_start, :shipment_end, :co2_emissions
  validates_numericality_of :distance_traveled, :fuel_consumption, :co2_emissions
end
