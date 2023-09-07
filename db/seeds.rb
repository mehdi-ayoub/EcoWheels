
puts "Cleaning the database"
Shipment.destroy_all
User.destroy_all


puts "Creating a User"

hai = User.create!(email: "hai@gmail.com", password: "hai@gmail.com", first_name: "hai dinh", last_name: "nguyen")
haya = User.create!(email: "haya@gmail.com", password: "haya@gmail.com", first_name: "haya", last_name: "bannout")
mehdi = User.create!(email: "mehdi@gmail.com", password: "mehdi@gmail.com", first_name: "mehdi", last_name: "ayoub")
josua = User.create!(email: "josua@gmail.com", password: "josua@gmail.com", first_name: "josua", last_name: "hasler")
kim = User.create!(email: "kim@gmail.com", password: "kim@gmail.com", first_name: "kim", last_name: "ruiven")
test = User.create!(email: "test@gmail.com", password: "test@gmail.com", first_name: "test", last_name: "test")

users = [hai, haya, mehdi, josua, kim]

puts "Creating Seed data!"

vehicle_type = ['4 Cylinder', '6 Cylinder', '8 Cylinder', 'Heavy Truck', 'Medium Truck']

fuel_type = ['Gasoline', 'Diesel']

product_names = [
  "Smartphone",
  "Laptop",
  "Digital Camera",
  "Bluetooth Speaker",
  "Coffee Maker",
  "Fitness Tracker",
  "Headphones",
  "Smartwatch",
  "Tablet",
  "Gaming Console",
  "Television",
  "Refrigerator",
  "Microwave Oven",
  "Toaster",
  "Washing Machine",
  "Blender",
  "Vacuum Cleaner",
  "Kitchen Mixer",
  "Desk Chair"
]

start_locations = [
  "Paris, France",
  "London, United Kingdom",
  "Barcelona, Spain",
  "Rome, Italy",
  "Amsterdam, Netherlands",
  "Prague, Czech Republic",
  "Vienna, Austria",
  "Berlin, Germany",
  "Athens, Greece",
  "Dublin, Ireland",
  "Lisbon, Portugal",
  "Budapest, Hungary",
  "Stockholm, Sweden",
  "Copenhagen, Denmark",
  "Warsaw, Poland",
  "Zurich, Switzerland",
  "Oslo, Norway",
  "Helsinki, Finland",
  "Brussels, Belgium",
  "Madrid, Spain",
  "Edinburgh, Scotland",
  "Venice, Italy",
  "Krakow, Poland",
  "Dubrovnik, Croatia",
  "Istanbul, Turkey",
  "Reykjavik, Iceland",
  "Munich, Germany",
  "Nice, France",
  "Santorini, Greece",
  "Florence, Italy",
  "Lyon, France",
  "Porto, Portugal",
  "Edinburgh, United Kingdom",
  "Amalfi Coast, Italy",
  "Salzburg, Austria",
  "Lucerne, Switzerland",
  "Bucharest, Romania",
  "Sofia, Bulgaria",
  "Valencia, Spain",
  "Bratislava, Slovakia",
  "Vilnius, Lithuania",
  "Tallinn, Estonia",
  "Riga, Latvia",
  "Minsk, Belarus",
  "Cork, Ireland",
  "Cologne, Germany",
  "Glasgow, United Kingdom",
  "Seville, Spain",
  "Naples, Italy"
]


end_locations = [
  "Budapest, Hungary",
  "Edinburgh, United Kingdom",
  "Krakow, Poland",
  "Granada, Spain",
  "Cinque Terre, Italy",
  "Santorini, Greece",
  "Amsterdam, Netherlands",
  "Dubrovnik, Croatia",
  "Ljubljana, Slovenia",
  "Bucharest, Romania",
  "Zagreb, Croatia",
  "Valencia, Spain",
  "Copenhagen, Denmark",
  "Bruges, Belgium",
  "Salzburg, Austria",
  "Lucerne, Switzerland",
  "Athens, Greece",
  "Nice, France",
  "Porto, Portugal",
  "Munich, Germany",
  "Lisbon, Portugal",
  "Siena, Italy",
  "Bratislava, Slovakia",
  "Vilnius, Lithuania",
  "Tallinn, Estonia",
  "Riga, Latvia",
  "Minsk, Belarus",
  "Cork, Ireland",
  "Cologne, Germany",
  "Glasgow, United Kingdom",
  "Seville, Spain",
  "Naples, Italy",
  "Belgrade, Serbia",
  "Oslo, Norway",
  "Helsinki, Finland",
  "Reykjavik, Iceland",
  "Warsaw, Poland",
  "Dublin, Ireland",
  "Bern, Switzerland",
  "Stockholm, Sweden",
  "Hague, Netherlands",
  "Florence, Italy",
  "Lyon, France",
  "Cambridge, United Kingdom",
  "Barcelona, Spain",
  "Vienna, Austria",
  "Berlin, Germany",
  "Rome, Italy",
  "Paris, France"
]


puts "Creating random shipments for users"

def random_date_in_past_2_years
  # This method returns a random date from the past two years.
  start_date = Date.today - 2.years
  end_date = Date.today
  rand(start_date..end_date)
end


users.each do |user|
  # We'll store generated dates to avoid repetition.
  used_dates = []

  50.times do # This will create 50 shipments for each user
    shipment_start = random_date_in_past_2_years
    shipment_end = random_date_in_past_2_years

    # Making sure shipment_end is always after shipment_start and dates are unique for this user.
    until shipment_end > shipment_start && !used_dates.include?([shipment_start, shipment_end])
      shipment_start = random_date_in_past_2_years
      shipment_end = random_date_in_past_2_years
    end

    # Store these dates so they won't be repeated for this user.
    used_dates << [shipment_start, shipment_end]

    chosen_end_location = end_locations.sample

    shipment_data = {
      city: chosen_end_location,
      vehicle_type: vehicle_type.sample,
      fuel_type: fuel_type.sample,
      fuel_consumption: "", # Leaving it empty
      product_name: product_names.sample,
      shipment_start: shipment_start,
      shipment_end: shipment_end,
      start_location: start_locations.sample,
      end_location: chosen_end_location,
      co2_emissions: "", # Leaving it empty
      user: user
    }

    Shipment.create!(shipment_data)
  end
end

puts "Database seeded!"
