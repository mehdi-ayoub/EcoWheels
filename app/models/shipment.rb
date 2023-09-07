class Shipment < ApplicationRecord
  include PgSearch::Model
  include DistanceHelper

  before_validation :geocode_start_and_end # Doing custom geocode cos we need to geocode 2 locations
  before_validation :calculate_distance # Now we calculate distance after we have geocoded locations
  before_validation :calculate_emissions

  belongs_to :user
  has_many_attached :photos

  validates_presence_of :distance_traveled, :vehicle_type, :fuel_type,
                      :fuel_consumption, :product_name, :shipment_start,
                      :shipment_end, :co2_emissions

  validates_numericality_of :distance_traveled, :fuel_consumption, :co2_emissions

  validates_presence_of :start_location, :end_location

  before_save :set_city_to_end_location

  pg_search_scope :search,
  against: [:city, :distance_traveled, :vehicle_type, :fuel_type, :product_name],
   using: {
    tsearch: { prefix: true }
   }

   private




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
    pp emission_service.call(self)
  end

  def geocode_start_and_end
    # Geocode start location if it exists
    if start_location
      # Use Geocoder gem to find results for the name of the location (This returns a list of results, of which we tak the first)
      geocoded = Geocoder.search(start_location).first
      # If the first exists, then we save the latitude and longitude to the shipment
      if geocoded
          self.start_latitude = geocoded.latitude
          self.start_longitude = geocoded.longitude
      end
    end
    # Geocode end location if it exists
    if end_location
      geocoded = Geocoder.search(end_location).first
      if geocoded
          self.end_latitude = geocoded.latitude
          self.end_longitude = geocoded.longitude
      end
    end
  end

  def set_city_to_end_location
    self.city = self.end_location
  end

end

# :start_latitude, :start_longitude, :end_latitude, :end_longitude,
