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
    create_new_recipients_deliveries(params)

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

  def create_new_recipients_deliveries(new_delivery)
    new_delivery[:delivery][:recipient_id].each do |recipient|
      unless recipient == ""
        delivery_time = Time.parse(new_delivery[:delivery][:send_time])
        delivery_date = DateTime.parse(new_delivery[:delivery][:send_date]).change(hour: delivery_time.strftime('%H').to_i, min: delivery_time.strftime('%M').to_i)
        @delivery = Delivery.new(new_delivery[:delivery])
        @delivery.recipient_id = recipient
        @delivery.send_date = delivery_date      
        @delivery.batch_id = Digest::MD5.hexdigest(@delivery.reminder_id.to_s + delivery_date.to_s)
        @delivery.save
        add_delivery_to_queue(@delivery)
      end
    end
  end

  def add_delivery_to_queue(delivery)
    theDate = delivery.send_date
    @recipient = Recipient.find(delivery.recipient_id)
    if theDate < DateTime.now
      Notifier.delay(priority: 0, run_at: DateTime.now).perform(@recipient, Reminder.find(delivery.reminder_id).message_text)
    else
      theJob = Notifier.delay(priority: 0, run_at: theDate.getutc).perform(@recipient, Reminder.find(delivery.reminder_id).message_text)
      delivery.update_attributes(job_id: theJob.id)
    end
  end
end
