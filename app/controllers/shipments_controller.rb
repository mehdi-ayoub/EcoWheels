class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.all
    if params[:query].present?
      @shipments = Shipment.where("name LIKE ?", "%#{params[:query]}%")
    else
      @shipments = Shipment.all
      # @planets = Shipment.search (params[:query])
    end
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
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update(shipment_params)
      redirect_to shipment_path(@shipment), notice: "Shipment successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shipment = Shipment.find(params[:id])

    # Ensure that only the owner can update the planet
    if current_user == @shipment.user
      if @shipment.destroy!
        redirect_to shipments_path, notice: "Planet was successfully deleted."
      else
        render :index
      end
    else
      redirect_to shipments_path, alert: "You are not authorized to delete this planet."
    end
  end

  private

  def shipment_params
    params.require(:shipment).permit(:city, :distance_traveled, :vehicle_type, :fuel_type, :fuel_consumption,
                                     :product_name, :shipment_start, :shipment_end, :co2_emissions)
  end
end
