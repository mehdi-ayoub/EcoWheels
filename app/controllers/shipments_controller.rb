class ShipmentsController < ApplicationController
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

    @shipment.save! # This triggers validation and geocoding

    # Check if geocoding was successful
    if @shipment.start_latitude && @shipment.start_longitude && @shipment.end_latitude && @shipment.end_longitude
      start_coordinates = [@shipment.start_latitude, @shipment.start_longitude]
      end_coordinates = [@shipment.end_latitude, @shipment.end_longitude]
      distance = Geocoder::Calculations.distance_between(start_coordinates, end_coordinates, :units => :km)
    else
      @shipment.distance_traveled = 0 # or some other default value
    end

    @shipment.co2_emissions = EmissionCalculatorService.new.call(shipment_params)
    @shipment.fuel_consumption = EmissionCalculatorService.new.calculate_fuel_consumption(shipment_params[:vehicle_type])

    if @shipment.save
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
      redirect_to shipment_path(@shipment), notice: "Shipment successfully updated."
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
