class Shipment < ApplicationRecord
  include PgSearch::Model

  geocoded_by :start_location, latitude: :start_latitude, longitude: :start_longitude
  geocoded_by :end_location, latitude: :end_latitude, longitude: :end_longitude

  after_validation :geocode_start_location, if: :start_location_changed?
  after_validation :geocode_end_location, if: :end_location_changed?

  belongs_to :user

  validates_presence_of :city
  #                       :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
  #                       :product_name, :shipment_start, :shipment_end, :co2_emissions
  # validates_numericality_of :distance_traveled, :fuel_consumption, :co2_emissions

  validates_presence_of :start_location, :end_location 

  pg_search_scope :search,
  against: [:city, :vehicle_type],
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

end

# :start_latitude, :start_longitude, :end_latitude, :end_longitude,
