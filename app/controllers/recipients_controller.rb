class RecipientsController < ApplicationController

  before_filter :set_recipient!, only: [ :show, :edit, :update, :destroy ]
  before_filter :standardize_numbers, only: [ :create, :update ]
  # before_filter :authenticate_user!
  load_and_authorize_resource
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

    respond_to do |format|
      if @recipient.save
        format.html { redirect_to @recipient, notice: 'Recipient was successfully created.' }
        format.json { render json: @recipient, status: :created, location: @recipient }
        @recipient.reports.try(:each) do |report|
          if @notification.send_date < DateTime.now
            Notifier.delay(priority: 1, run_at: DateTime.now).perform(@recipient, Message.find_by_report_id(report.id).messagetext)
          else
            theJob = Notifier.delay(priority: 1, run_at: @notification.send_date.getutc).perform(@recipient, Message.find_by_report_id(report.id).messagetext)
            Notifier.notification_add(@recipient, @notification.send_date, theJob.id)
          end
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
        @notification_new = Notification.new(params[:notifications])
        @recipient.reports.try(:each) do |report|
          @notification = Notification.find_by_report_id_and_recipient_id(report.id, @recipient.id)
          notifier_job = Delayed::Job.find_by_id(@notification.job_id)
          if notifier_job
            notifier_job.destroy
          end
          if @notification
             @notification.destroy 
          end
          # tie this to the params send date
          if @notification_new.send_date < DateTime.now
            Notifier.delay(priority: 1, run_at: DateTime.now).perform(@recipient, Message.find_by_report_id(report.id).messagetext)
          else
            theJob = Notifier.delay(priority: 1, run_at: @notification_new.send_date.getutc).perform(@recipient, Message.find_by_report_id(report.id).messagetext)
            Notifier.notification_add(@recipient, @notification_new.send_date, theJob.id)
          end
        end
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


