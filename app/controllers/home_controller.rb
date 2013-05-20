class HomeController < ApplicationController
  def index
    list_upcoming
    list_recent
    add_recipient
  end

  def add_recipient
    @add_recipient = Recipient.all
    # binding.pry

    respond_to do |format|
    # if @add_recipient.save
    #   format.html { redirect_to @add_recipient, notice: 'Recipient was successfully created.' }
    #   format.json { render json: @add_recipient, status: :created, location: @add_recipient }

    #   # Notifier.perform(@add_recipient, "Thanks, we'll remind you of your report on: #{@add_recipient.reminder_date.to_s(:date_format)}.")
    #   # if @add_recipient.reminder_date < DateTime.now
    #   #   Notifier.perform(@add_recipient, "Your report is due in 3 days.")
    #   # else
    #   #   Delayed::Job.enqueue(Notifier.perform(@add_recipient, "Your report is due in 3 days."), @add_recipient.reminder_date)
    #   # end
    # else
      format.html { render :inline => @add_recipient }
      # format.json { render json: @add_recipient.errors, status: :unprocessable_entity }
    # end
    end
  end

  def list_upcoming
  	# list queued
  end

  # GET /conversations
  def list_recent
  	@recents = Conversation.all

    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @recents }
    # end
  end

end
