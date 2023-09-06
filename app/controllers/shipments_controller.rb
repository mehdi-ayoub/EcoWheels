class ShipmentsController < ApplicationController
  include DistanceHelper

  def index


    if params[:query].present?
      @shipments = Shipment.search(params[:query])
    else
      @shipments = Shipment.all
    end
    @shipments = policy_scope(@shipments)
  end

  def new
    @shipment = Shipment.new
    authorize @shipment
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.user = current_user
    authorize @shipment

    if @shipment.save
      emission_service = EmissionCalculatorService.new

      # Calculate CO2 emissions and fuel consumption

      @shipment.fuel_consumption = emission_service.calculate_fuel_consumption(shipment_params[:vehicle_type])
      @shipment.co2_emissions = emission_service.call(@shipment)
      @shipment.save

      redirect_to shipments_path, notice: "A shipment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @shipment = Shipment.find(params[:id])
    authorize @shipment
  end

  def edit
    @shipment = Shipment.find(params[:id])

    authorize @shipment
    redirect_to shipments_path, notice: "Shipment successfully edited."
  end

  def update
    @shipment = Shipment.find(params[:id])
    authorize @shipment

    if @shipment.update(shipment_params)
      # Calculate distance if latitudes and longitudes are their
      if @shipment.start_latitude.present? && @shipment.start_longitude.present? && @shipment.end_latitude.present? && @shipment.end_longitude.present?
        calculated_distance = haversine_distance(@shipment.start_latitude, @shipment.start_longitude, @shipment.end_latitude, @shipment.end_longitude).round(2)
        @shipment.update(distance_traveled: calculated_distance)
      else
        @shipment.update(distance_traveled: 0)
      end


      # Save
      # Recalculate fuel consumption and CO2 emissions
      emission_service = EmissionCalculatorService.new
      @shipment.fuel_consumption = emission_service.calculate_fuel_consumption(@shipment.vehicle_type)
      @shipment.co2_emissions = emission_service.call(shipment_params)
      if @shipment.save
        redirect_to shipments_path, notice: "Shipment was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shipment = Shipment.find(params[:id])

    authorize @shipment

    # Ensure that only the owner can update the planet
    if current_user == @shipment.user
      if @shipment.destroy!
        redirect_to shipments_path, notice: "Shipment was successfully deleted."
      else
        render :index
      end
    else
      redirect_to shipments_path, alert: "You are not authorized to delete this Shipment."
    end
  end


  private

  def shipment_params
    params.require(:shipment).permit(:product_name, :city, :shipment_start, :shipment_end, :vehicle_type, :fuel_type, :start_location, :end_location, :distance_traveled)
  end
end
