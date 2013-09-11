class RemindersController < ApplicationController
  include Helper
  load_and_authorize_resource
  
  def index
    @groups = Reminder.grouped_reminders

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  def show 
    @reminder = Reminder.where("batch_id=?", params[:batch_id])
  end


  def new
    @reminder = Reminder.new
    @reminders = @reminder.build_message
    @recipients = @reminder.build_recipient

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @reminders = Reminder.where("batch_id=?", params[:batch_id])
  end

  # POST /deliveries
  # POST /deliveries.json
  def create

    if params[:message]
      @message = Message.new(params[:message])
      @message.save
      params[:reminder][:message_id] = @message.id.to_s
    end

    recipients_to_add = Array.new
    recipients_to_add << params[:recipient][:phone]
    recipients_to_add.each do |recipient|
      if current_user_exists?(recipient).empty?
        @recipient = Recipient.new(params[:recipient])
        @recipient.save
        params[:reminder][:recipient_id] << @recipient.id.to_s
      else
        @recipient = Recipient.where('phone=?', recipients_to_add).first
        params[:reminder][:recipient_id] << @recipient.id.to_s
      end
    end

    params[:reminder][:recipient_id].each do |recipient|
      # for some reason there is always a null recipient. fix this
      if recipient !=""
        Reminder.create_new_recipients_reminders(Recipient.find(recipient), params[:recipient_send_date], params[:recipient_send_time], Message.find(params[:reminder][:message_id]))
      end
    end

    respond_to do |format|
      format.html { redirect_to reminders_url, notice: 'Reminder was successfully created.' }
      format.json { render json: @reminder, status: :created, location: @reminder }
    end
  end

  def update
    @reminder = Reminder.where("batch_id=?", params[:batch_id])
    binding.pry

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to reminders_path, notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy
    @delay = Delayed::Job.find(@reminder.job_id)

    respond_to do |format|
      format.html { redirect_to reminders_url }
      format.json { head :no_content }
    end
  end

  def import
    Reminder.import(params[:file], params[:reminder])
    redirect_to reminders_url, notice: "Reminder created."
  end
end
