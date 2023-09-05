# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

hai = User.create(email: "hai@gmail.com", password: "hai@gmail.com", first_name: "hai dinh", last_name: "nguyen")

shipment1 = Shipment.create!(city: "London", vehicle_type: "Car", user: hai)
shipment2 = Shipment.create!(city: "Paris", vehicle_type: "Truck", user: hai)

shipment2 = Shipment.create!(city: "Paris", vehicle_type: "Truck", user_id: 1)
shipment2 = Shipment.create!(city: "London", vehicle_type: "Truck", user_id: 2)
