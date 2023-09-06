class ShipmentsController < ApplicationController
  include DistanceHelper

  def index
    @shipments = current_user.shipments
    @shipments = filter_shipments(@shipments)

    if params[:sort_by]
      @shipments = sort_shipments(@shipments)
    end

    if params[:query].present?
      @shipments = @shipments.search(params[:query])
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

    emission_service = EmissionCalculatorService.new
    @shipment.fuel_consumption = emission_service.calculate_fuel_consumption(shipment_params[:vehicle_type])
    @shipment.co2_emissions = emission_service.call(@shipment)
    @shipment.save

    # if @shipment.update(shipment_params)

      # Save
      # Recalculate fuel consumption and CO2 emissions
      # emission_service = EmissionCalculatorService.new
      # @shipment.fuel_consumption = emission_service.calculate_fuel_consumption(@shipment.vehicle_type)
      # @shipment.co2_emissions = emission_service.call(shipment_params)


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
    authorize @shipment
    @shipment = Shipment.find(params[:id])

<<<<<<< HEAD
    authorize @shipment

    # Ensure that only the owner can update the planet
    if current_user == @shipment.user
      if @shipment.destroy!
        redirect_to shipments_path, notice: "Shipment was successfully deleted."
=======
    if current_user == @shipment.user
      if @shipment.destroy!
        redirect_to shipments_path, notice: "The shipment was successfully deleted."
>>>>>>> master
      else
        render :index
      end
    else
<<<<<<< HEAD
      redirect_to shipments_path, alert: "You are not authorized to delete this Shipment."
=======
      redirect_to shipments_path, alert: "You are not authorized to delete this shipment."
>>>>>>> master
    end
  end


  private

  def shipment_params
    params.require(:shipment).permit(:product_name, :city, :shipment_start, :shipment_end, :vehicle_type, :fuel_type, :start_location, :end_location, :distance_traveled)
  end

  def sort_shipments(shipments)
    shipments.order(params[:sort_by])
  end

  def filter_shipments(shipments)
    shipments = shipments.where(city: params[:city]) if params[:city].present?
    shipments = shipments.where(vehicle_type: params[:vehicle_type]) if params[:vehicle_type].present?
    shipments = shipments.where(fuel_type: params[:fuel_type]) if params[:fuel_type].present?
    shipments = shipments.where(product_name: params[:product_name]) if params[:product_name].present?
    shipments = shipments.where("shipment_start >= ?", params[:shipment_start]) if params[:shipment_start].present?
    shipments = shipments.where("shipment_end <= ?", params[:shipment_end]) if params[:shipment_end].present?
    shipments = shipments.where(co2_emissions: params[:co2_emissions]) if params[:co2_emissions].present?
    shipments
  end
end
