class ShipmentsController < ApplicationController
  def index
    @shipments = current_user.shipments
    @shipments = sort_shipments(@shipments) if params[:sort_by]
    @shipments = filter_shipments(@shipments)
  end

  def new
    @shipment = Shipment.new
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.user = current_user
    if @shipment.save
      redirect_to shipments_path, notice: "A shipment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @shipment = Shipment.find(params[:id])

    # Ensure that only the owner can update the planet
    if current_user == @shipment.user
      if @shipment.destroy!
        redirect_to shipments_path, notice: "The shipment was successfully deleted."
      else
        render :index
      end
    else
      redirect_to shipments_path, alert: "You are not authorized to delete this shipment."
    end
  end

  private

  def shipment_params
    params.require(:shipment).permit(:city, :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
                                     :product_name, :shipment_start, :shipment_end, :co2_emissions)
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
