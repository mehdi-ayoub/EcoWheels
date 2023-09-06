class Shipment < ApplicationRecord
  include PgSearch::Model
  include DistanceHelper

  geocoded_by :start_location, latitude: :start_latitude, longitude: :start_longitude
  geocoded_by :end_location, latitude: :end_latitude, longitude: :end_longitude

  before_validation :geocode_start_location, if: :start_location_changed?
  before_validation :geocode_end_location, if: :end_location_changed?
  before_validation :calculate_distance
  before_validation :calculate_emissions

  belongs_to :user

  validates_presence_of :city,
                        :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
                        :product_name, :shipment_start, :shipment_end, :co2_emissions
  validates_numericality_of :distance_traveled, :fuel_consumption, :co2_emissions

  validates_presence_of :city, :distance_traveled, :vehicle_type, :fuel_type,
                      :fuel_consumption, :product_name, :shipment_start,
                      :shipment_end, :co2_emissions

  validates_presence_of :start_location, :end_location

  pg_search_scope :search,
  against: [:city, :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
    :product_name, :shipment_start, :shipment_end, :co2_emissions],
   using: {
    tsearch: { prefix: true }
   }

   private

  def geocode_start_location
    coords = Geocoder.coordinates(self.start_location)
    self.start_latitude = coords[0]
    self.start_longitude = coords[1]
  end

  def geocode_end_location
    coords = Geocoder.coordinates(self.end_location)
    self.end_latitude = coords[0]
    self.end_longitude = coords[1]
  end

  def calculate_distance
    self.distance_traveled = haversine_distance(
      self.start_latitude,
      self.start_longitude,
      self.end_latitude,
      self.end_longitude

    ).round(2)
  end

  def calculate_emissions
    emission_service = EmissionCalculatorService.new

    # Calculate CO2 emissions and fuel consumption

    self.fuel_consumption = emission_service.calculate_fuel_consumption(vehicle_type)

    self.co2_emissions = emission_service.call(self)
  end
end

# :start_latitude, :start_longitude, :end_latitude, :end_longitude,
