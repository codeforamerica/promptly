class ReminderImportsController < ApplicationController
  include ActionView::Helpers::TextHelper

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
    success = 0
    fail = 0
    @reminder_import = params[:reminder_import]
    @reminder_import.map do |r|
      if save_new_reminders(r[1]).is_a? Reminder
        success = success + 1
      else
        fail = fail + 1
      end
    end
    @success = success
    @fail = fail
    redirect_to reminders_url, notice: "Imported #{pluralize(success, 'reminder')} successfully. #{pluralize(fail, 'failure')}"
  end

  def save_new_reminders(reminders)
    recipient = Recipient.where(phone: reminders['phone']).first_or_create
    text_message = Message.find(reminders['message'])
    Reminder.create_new_recipients_reminders(recipient, reminders['send_date'], send_time = '12:00pm', text_message)    
  end

end