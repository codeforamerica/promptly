class DeliveryImportsController < ApplicationController
  def new
    @delivery_import = DeliveryImport.new
  end

  def create
    @delivery_import = DeliveryImport.new(params[:delivery_import])
    if @delivery_import.save
      redirect_to root_url, notice: "Imported deliveries successfully."
    else
      render :new
    end
  end
end