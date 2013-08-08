class RemindersController < ApplicationController
  # GET /reminders
  # GET /reminders.json
  load_and_authorize_resource
  
  def index
  	@reminders = Reminder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
    @reminder = Reminder.find(params[:id])

  end

  # GET /reminders/new
  # GET /reminders/new.json
  def new
    @reminder = Reminder.new
    @reminder.deliveries.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.json
  def create
    @reminder = Reminder.new(params[:reminder])
    # format the date    
    params[:reminder][:deliveries_attributes].values.each do |delivery|
      @send_date = delivery[:send_date]
    end
    respond_to do |format|
      if @reminder.save
        # Create the batch id for this delivery
        batch_id = @reminder.deliveries.last.id
        # Add the date to all the recipients
        @reminder.deliveries.each do |delivery|
          delivery.send_date = @send_date
          delivery.batch_id = batch_id
          delivery.save
        end

        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.json
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url }
      format.json { head :no_content }
    end
  end
end
