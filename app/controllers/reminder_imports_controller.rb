class ReminderImportsController < ApplicationController

  def new
    @reminder_import = ReminderImport.new
    @messages = Reminder.new.build_message
    @reminder = Reminder.new
  end

  def review
    @reminder_import = ReminderImport.new(params[:reminder_import], params[:message_id])
    @reminder_import.review
  end

  def create
    # @reminder_import = ReminderImport.new(params[:reminder_import], params[:message_id])
    # binding.pry
    # @reminder_import.review
    if @reminder_import.save
      redirect_to reminders_url, notice: "Imported reminders successfully."
    else
      render :new
    end
  end

end