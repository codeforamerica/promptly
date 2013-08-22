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
    @reminder_import = params[:reminder_import]
    @reminder_import.map do |r|
      save_new_reminders(r[1])
    end
    redirect_to reminders_url, notice: "Imported reminders successfully."
  end

  def save_new_reminders(reminders)
    recipient = Recipient.where(phone: reminders['phone']).first_or_create
    text_message = Message.find(reminders['message'])
    Reminder.create_new_recipients_reminders(recipient, reminders['send_date'], send_time = '12:00pm', text_message)    
  end

end