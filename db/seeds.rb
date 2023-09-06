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

hai = User.create(email: "hai@gmail.com", password: "hai@gmail.com", first_name: "hai dinh", last_name: "nguyen")

# Create some products
10.times do
  Shipment.create(city: 'Rotterdam', vehicle_type: Faker::Vehicle.make_and_model, fuel_type: 'diesel', user: hai, distance_traveled: '10', fuel_consumption: '20', product_name: 'Nike', shipment_start: '13 september', shipment_end: '12 december', co2_emissions: '30')
end
