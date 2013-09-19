class RemindersController < ApplicationController
  include Helper
  load_and_authorize_resource
  
  def index
    @groups = Reminder.grouped_reminders
    @sent = Conversation.all

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
    @message = @reminder.build_message
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


  def create
    binding.pry
    if params[:message]
      @message = Message.new(params[:message])
      @message.save
      params[:reminder][:message_id] = @message.id.to_s
    end

    if params[:individual_recipients]
      individual_recipients = parse_and_add_phone_numbers(params[:individual_recipients])
      individual_recipients.each { |ir| params[:recipient_id] = ir }
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
    @reminder.each do |r|
      r.update_attributes(params[:reminder])
    end
    respond_to do |format|
      format.html { redirect_to reminders_path, notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      # if @reminder.update_attributes(params[:reminder])
      #   format.html { redirect_to reminders_path, notice: 'Reminder was successfully updated.' }
      #   format.json { head :no_content }
      # else
      #   format.html { render action: "edit" }
      #   format.json { render json: @reminder.errors, status: :unprocessable_entity }
      # end
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


  private
  def add_indiv_recipients
    
  end

end
