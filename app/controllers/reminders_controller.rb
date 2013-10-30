class RemindersController < ApplicationController
  include Helper
  load_and_authorize_resource
  
  def index
    @groups = Reminder.grouped_reminders
    @sent = Conversation.grouped_sent_conversations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  def show 
    @reminders = Reminder.where("batch_id=? AND send_date >=?", params[:batch_id], DateTime.now)
  end


  def new
    @reminder = Reminder.new
    @message = @reminder.build_message
    @recipients = @reminder.build_recipient
    @group = Group.new
    @messages_search = Message.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @reminders = Reminder.where("batch_id=?", params[:batch_id])
  end

  def confirm
    @reminder = Reminder.new
    # @individual_recipients = parse_phone_numbers(params[:individual_recipients])
    # If they didn't create a new message,
    # get the one from the radio button and add it to the reminder
    
    # if params[:reminder][:message_id].nil? && params[:message_id].nil?
    #   raise 
    params[:reminder][:message_id] = params[:message_id] if params[:reminder][:message_id].nil?    
    @groups = Group.where(:id => params[:group_ids])
    
    if params[:group_ids].nil? 
      unless params[:group].nil?
        new_group = Group.where(name: params[:group][:name]).first_or_create
        recipients = group_to_recipient_ids(new_group.id)
      end
    else 
      unless params[:group].nil?
        if params[:group][:name] != ""
          new_group = Group.where(name: params[:group][:name]).first_or_create
          params[:group_ids] << new_group.id
        end
      end
      recipients = group_to_recipient_ids(params[:group_ids])
    end
  end

  def create
    @reminder = Reminder.new
    params[:reminder][:group_ids].each do |group|
      @recipients = Group.find(group).recipients
      @recipients.each do |recipient|
        Reminder.create_new_recipients_reminders(recipient, Message.find(params[:reminder][:message_id]), params[:reminder][:send_date], send_time: params[:reminder][:send_time], group_id: group)
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
    end
  end

  def destroy
    @reminders = Reminder.where('batch_id=?', params[:batch_id])
    @reminders.each do |reminder|
      destroy_delayed_job_by_job_id(reminder.job_id)     
      reminder.destroy
    end

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
