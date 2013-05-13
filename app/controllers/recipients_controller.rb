class RecipientsController < ApplicationController

  before_filter :set_recipient!, only: [ :show, :edit, :update, :destroy ]
  before_filter :standardize_numbers, only: [ :create, :update ]
  after_filter :log_conversation, only: [ :create, :update]
  # GET /recipients
  # GET /recipients.json
  def index
    @recipients = Recipient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipients }
    end
  end

  # GET /recipients/1
  # GET /recipients/1.json
  def show
    @report = @recipient.reports

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipient }
    end
  end

  # GET /recipients/new
  # GET /recipients/new.json
  def new
    @recipient = Recipient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipient }
    end
  end

  # GET /recipients/1/edit
  def edit
  end

  # POST /recipients
  # POST /recipients.json
  def create
    @recipient = Recipient.new(params[:recipient])
    # binding.pry

    respond_to do |format|
      if @recipient.save
        @conversation = Conversation.new
        format.html { redirect_to @recipient, notice: 'Recipient was successfully created.' }
        format.json { render json: @recipient, status: :created, location: @recipient }

        #send confirmation
        twilio_sid = ENV['TWILIO_SID']
        twilio_token = ENV['TWILIO_TOKEN']
        twilio_phone_number = ENV['TWILIO_NUMBER']

        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
        # binding.pry
        @message = @twilio_client.account.sms.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => "+1#{@recipient.phone}",
          :body => "Thanks we'll remind you of your report on: #{@recipient.reminder_date.to_s(:date_format)}."
          # :StatusCallback => 'conversations/new'
        )
        # binding.pry
        @conversation.date = DateTime.now
        @conversation.message = @message.body
        @conversation.to_number = @message.number
        @conversation.from_number = twilio_phone_number
        @conversation.save
      else
        format.html { render action: "new" }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipients/1
  # PUT /recipients/1.json
  def update
    respond_to do |format|
      if @recipient.update_attributes(params[:recipient])
        format.html { redirect_to @recipient, notice: 'Recipient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipients/1
  # DELETE /recipients/1.json
  def destroy
    @recipient.destroy

    respond_to do |format|
      format.html { redirect_to recipients_url }
      format.json { head :no_content }
    end
  end

  private

  def set_recipient!
    @recipient = Recipient.find(params[:id])
  end

  private 

  # Intercepts the params hash and formats the phone number
  def standardize_numbers
    params[:recipient][:phone].gsub!(/[^0-9]/, "")
  end

  private

  def log_conversation
    @conversation = Conversation.new
  end
end