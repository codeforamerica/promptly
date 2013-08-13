class DeliveriesController < ApplicationController
  # GET /deliveries
  # GET /deliveries.json
  load_and_authorize_resource
  
  def index
  	@groups = Delivery.grouped_deliveries

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deliveries }
    end
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show 
    @deliveries = Delivery.where("batch_id=?", params[:batch_id])
  end

  # GET /deliveries/new
  # GET /deliveries/new.json
  def new
    @delivery = Delivery.new
    @reminders = @delivery.build_reminder

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @delivery = Delivery.find(params[:id])
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    if params[:reminder]
      @reminder = Reminder.new(params[:reminder])
      @reminder.save
      params[:delivery][:reminder_id] = @reminder.id.to_s
    end
    params[:delivery][:recipient_id].each do |recipient|
      # for some reason there is always a null recipient. fix this
      if recipient !=""
        Delivery.create_new_recipients_deliveries(Recipient.find(recipient), params[:delivery][:send_date], params[:delivery][:send_time], Reminder.find(params[:delivery][:reminder_id]))
      end
    end

    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully created.' }
      format.json { render json: @delivery, status: :created, location: @delivery }
    end
  end

  # PUT /deliveries/1
  # PUT /deliveries/1.json
  def update
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        format.html { redirect_to @deliveries, notice: 'Delivery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    @delay = Delayed::Job.find(@delivery.job_id)

    respond_to do |format|
      format.html { redirect_to deliveries_url }
      format.json { head :no_content }
    end
  end

  def import
    Delivery.import(params[:file], params[:reminder])
    redirect_to deliveries_url, notice: "Delivery created."
  end
end
