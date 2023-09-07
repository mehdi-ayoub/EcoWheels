# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Coding this method on the class
User.destroy_all
Shipment.destroy_all


puts "Cleaning the database"
Shipment.destroy_all
User.destroy_all


puts "Creating a User"

hai = User.create!(email: "hai@gmail.com", password: "hai@gmail.com", first_name: "hai dinh", last_name: "nguyen")
john_doe = User.create!(email: "john.doe@example.com", password: "john.doe@example.com", first_name: "john", last_name: "doe")

puts "Creating Seed data!"

# Create Shipments for hai
Shipment.create!(
  city: 'Los Angeles',
  vehicle_type: 'Heavy Truck',
  fuel_type: 'Diesel',
  fuel_consumption: 12.5,
  product_name: 'Electronics',
  shipment_start: Date.today - 10,
  shipment_end: Date.today - 5,
  start_location: 'Paris',
  end_location: 'london',
  co2_emissions: 120.4,
  user: hai
)

# Shipment.create!(
#   city: 'New York',
#   vehicle_type: 'Medium Truck',
#   fuel_type: 'Diesel',
#   fuel_consumption: 500.0,
#   product_name: 'Furniture',
#   shipment_start: Date.today - 20,
#   shipment_end: Date.today - 10,
#   start_latitude: 34.0549,
#   start_longitude: 118.2426,
#   end_latitude: 32.7157,
#   end_longitude: 17.1611,
#   co2_emissions: 540.3,
#   user: hai
# )

# Shipment.create!(
#   city: 'Chicago',
#   vehicle_type: 'Medium Truck',
#   fuel_type: 'Gasoline',
#   fuel_consumption: 0.5,
#   product_name: 'Automobile Parts',
#   shipment_start: Date.today - 7,
#   shipment_end: Date.today - 2,
#   start_latitude: 34.0549,
#   start_longitude: 118.2426,
#   end_latitude: 32.7157,
#   end_longitude: 17.1611,
#   co2_emissions: 0.2,
#   user: hai
# )

# # Creating shipments for john_doe
# Shipment.create!(
#   city: "Boston",
#   vehicle_type: "8 Cylinder",
#   fuel_type: "Gasoline",
#   fuel_consumption: 10.5,
#   product_name: "Electronics",
#   shipment_start: "2023-08-10",
#   shipment_end: "2023-08-15",
#   start_latitude: 34.0549,
#   start_longitude: 118.2426,
#   end_latitude: 32.7157,
#   end_longitude: 17.1611,
#   co2_emissions: 100.4,
#   user: john_doe
# )

# Shipment.create!(
#   city: "Washington DC",
#   vehicle_type: "8 Cylinder",
#   fuel_type: "Diesel",
#   fuel_consumption: 500.0,
#   product_name: "Furniture",
#   shipment_start: "2023-09-05",
#   shipment_end: "2023-09-10",
#   start_latitude: 34.0549,
#   start_longitude: 118.2426,
#   end_latitude: 32.7157,
#   end_longitude: 17.1611,
#   co2_emissions: 1500.0,
#   user: john_doe
# )

# Shipment.create!(
#   city: "Alberta",
#   vehicle_type: "Heavy Truck",
#   fuel_type: "Gasoline",
#   fuel_consumption: 8.0,
#   product_name: "Books",
#   shipment_start: "2023-07-20",
#   shipment_end: "2023-07-22",
#   start_latitude: 34.0549,
#   start_longitude: 118.2426,
#   end_latitude: 32.7157,
#   end_longitude: 17.1611,
#   co2_emissions: 60.0,
#   user: john_doe
# )

# Shipment.create!(
#   city: 'Denver',
#   vehicle_type: '4 Cylinder',
#   fuel_type: 'Diesel',
#   fuel_consumption: 0,
#   product_name: 'Consumer goods',
#   shipment_start: Date.today - 10,
#   shipment_end: Date.today - 5,
#   start_latitude: 34.0549,
#   start_longitude: 118.2426,
#   end_latitude: 32.7157,
#   end_longitude: 17.1611,
#   co2_emissions: 0.2,
#   user: hai
# )

# puts "Seed data created successfully!"
