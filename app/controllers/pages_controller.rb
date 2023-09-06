class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @result = 0
  end

  def calculate_emissions

    car_type = params[:pages][:car_type]
    fuel_type = params[:pages][:fuel_type]
    distance_traveled = params[:pages][:distance_traveled].to_f

    fuel_consumption = calculate_fuel_consumption(car_type)
    carbon_content = calculate_carbon_content(fuel_type)

    co2_emissions = (fuel_consumption / 100) * distance_traveled * carbon_content
    @result = co2_emissions.round(2)

    # If the distance traveled is zero, set @result to 0 by default

    respond_to do |format|
      format.turbo_stream
    end
  end

  def dashboard
    @shipments = current_user.shipments

    if params[:sort_by]
      @shipments = sort_shipments(@shipments)
    end

    if params[:query].present?
      @shipments = @shipments.search(params[:query])
    end

    @shipments = policy_scope(@shipments)
  end

  private

  def calculate_fuel_consumption(car_type)
    case car_type
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
