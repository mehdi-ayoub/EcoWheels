class EmissionCalculatorService < ApplicationService
  attr_accessor :vehicle_type, :fuel_type, :distance_traveled

  def initialize
  end

  def call(params)

    vehicle_type = params[:vehicle_type]
    fuel_type = params[:fuel_type]
    distance_traveled = params[:distance_traveled].to_f

    fuel_consumption = calculate_fuel_consumption(vehicle_type)
    carbon_content = calculate_carbon_content(fuel_type)

    co2_emissions = (fuel_consumption / 100) * distance_traveled * carbon_content
    co2_emissions.round(2)

    # If the distance traveled is zero, set @result to 0 by default
  end

  def calculate_fuel_consumption(vehicle_type)
    case vehicle_type
    when '4 Cylinder'
      7.29
    when '6 Cylinder'
      9.4
    when '8 Cylinder'
      13.3
    when 'Heavy Truck'
      25.0
    when 'Medium Truck'
      17.5
    else
      0.0
    end
  end

  def calculate_carbon_content(fuel_type)
    case fuel_type
    when 'Gasoline'
      2.31
    when 'Diesel'
      2.68
    else
      0.0
    end
  end
end
