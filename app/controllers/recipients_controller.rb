class RecipientsController < ApplicationController

  before_filter :set_recipient!, only: [ :show, :edit, :update, :destroy ]
  before_filter :standardize_numbers, only: [ :create, :update ]
  # after_filter :log_conversation, only: [ :create, :update]
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
    # @conversations = Conversation.all
    # binding.pry

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
    @notification = Notification.new(params[:notifications])
    # binding.pry

    respond_to do |format|
      if @recipient.save
        format.html { redirect_to @recipient, notice: 'Recipient was successfully created.' }
        format.json { render json: @recipient, status: :created, location: @recipient }
        @recipient.reports.each do |report|
          Notifier.perform(@recipient, "Your #{report.humanname} report is due #{@notification.send_date.to_s(:date_format)}. We will remind you one week before. Text STOP to stop these text messages.")
          if @notification.send_date < DateTime.now
            Notifier.perform(@recipient, "Your #{report.humanname} report is due on Monday, May 27th. Need help? Call (415) 558-1001.")
          else
            # use Notifier.new here so delayed job can hook into the perform method
            Delayed::Job.enqueue(Notifier.new(@recipient, "Your #{report.humanname} report is due #{@notification.send_date.to_s(:date_format)}. Need help? Call (415) 558-1001."), @notification.send_date)
          end
          @notification.report_id = report.id
          @notification.recipient_id = @recipient.id
          @notification.send_date = @notification.send_date
          
          @notification.save
        end
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

  def import
    Recipient.import(params[:file])
    redirect_to root_url, notice: "Users imported."
  end

  private

  def set_recipient!
    @recipient = Recipient.find(params[:id], include: [:notifications])
  end

  private 

  # Intercepts the params hash and formats the phone number
  def standardize_numbers
    params[:recipient][:phone].gsub!(/[^0-9]/, "")
  end
end


