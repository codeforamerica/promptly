class MessagesController < ApplicationController
  load_and_authorize_resource
  
  def index
  	@messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
      format.js
    end
  end

  def show
    @message = Message.find(params[:id])

  end

  def new
    @message = Message.new
    @message.reminders.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
      
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    # format the date    
    # params[:message][:reminders_attributes].values.each do |reminder|
    #   @send_date = reminder[:send_date]
    # end
    respond_to do |format|
      if @message.save
        # Create the batch id for this reminder
        # batch_id = @message.reminders.last.id
        # # Add the date to all the recipients
        # @message.reminders.each do |reminder|
        #   reminder.send_date = @send_date
        #   reminder.batch_id = batch_id
        #   reminder.save
        # end

        format.js
        format.html { redirect_to @message, notice: 'Reminder was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
