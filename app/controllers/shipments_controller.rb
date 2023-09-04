class ShipmentsController < ApplicationController
  def index
    @shipments = @Shipment.all
  end

  def new
    @shipment = Shipment.new
  end

  def create
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
    params.require(:shipment).permit()
  end
end
