class DeliveryImportsController < ApplicationController
  def new
    @delivery_import = DeliveryImport.new
    @reminders = Delivery.new.build_reminder
    @delivery = Delivery.new
  end

  def create
    @delivery_import = DeliveryImport.new(params[:delivery_import], params[:reminder_id])
    if @delivery_import.save
      redirect_to deliveries_url, notice: "Imported deliveries successfully."
    else
      render :new
    end
  end
end