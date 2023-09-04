class ShipmentsController < ApplicationController
  def index
    @shipments = @Shipment.all
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
    @shipment = Shipment.find(params[:id])
  end

  def edit
    @shipment = Shipment.find(params[:id])
    redirect_to shipments_path, notice: "Shipment successfully edited."
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update(shipment_params)
      redirect_to shipment_path(@shipment), notice: "Shipment successfully edited."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def shipment_params
    params.require(:shipment).permit(:city, :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
                                     :product_name, :shipment_start, :shipment_end, :co2_emissions)
  end
end
