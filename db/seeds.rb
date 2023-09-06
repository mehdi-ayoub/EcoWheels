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
  distance_traveled: 120.5,
  vehicle_type: 'Truck',
  fuel_type: 'Diesel',
  fuel_consumption: 12.5,
  product_name: 'Electronics',
  shipment_start: Date.today - 10,
  shipment_end: Date.today - 5,
  co2_emissions: 120.4,
  user: hai
)

Shipment.create!(
  city: 'New York',
  distance_traveled: 240.7,
  vehicle_type: 'Airplane',
  fuel_type: 'Jet Fuel',
  fuel_consumption: 500.0,
  product_name: 'Furniture',
  shipment_start: Date.today - 20,
  shipment_end: Date.today - 10,
  co2_emissions: 540.3,
  user: hai
)

Shipment.create!(
  city: 'Chicago',
  distance_traveled: 80.2,
  vehicle_type: 'Train',
  fuel_type: 'Electric',
  fuel_consumption: 0.5,
  product_name: 'Automobile Parts',
  shipment_start: Date.today - 7,
  shipment_end: Date.today - 2,
  co2_emissions: 0.2,
  user: hai
)

# Creating shipments for john_doe
Shipment.create!(
  city: "Boston",
  distance_traveled: 150.5,
  vehicle_type: "Truck",
  fuel_type: "Diesel",
  fuel_consumption: 10.5,
  product_name: "Electronics",
  shipment_start: "2023-08-10",
  shipment_end: "2023-08-15",
  co2_emissions: 100.4,
  user: john_doe
)

Shipment.create!(
  city: "Washington DC",
  distance_traveled: 300.0,
  vehicle_type: "Plane",
  fuel_type: "Jet Fuel",
  fuel_consumption: 500.0,
  product_name: "Furniture",
  shipment_start: "2023-09-05",
  shipment_end: "2023-09-10",
  co2_emissions: 1500.0,
  user: john_doe
)

Shipment.create!(
  city: "Alberta",
  distance_traveled: 50.0,
  vehicle_type: "Van",
  fuel_type: "Gasoline",
  fuel_consumption: 8.0,
  product_name: "Books",
  shipment_start: "2023-07-20",
  shipment_end: "2023-07-22",
  co2_emissions: 60.0,
  user: john_doe
)

Shipment.create!(
  city: 'Denver',
  distance_traveled: 180.2,
  vehicle_type: 'Hyperloop',
  fuel_type: 'Electric',
  fuel_consumption: 0,
  product_name: 'Consumer goods',
  shipment_start: Date.today - 10,
  shipment_end: Date.today - 5,
  co2_emissions: 0.2,
  user: hai
)

puts "Seed data created successfully!"
