class ReminderImportsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  attr_accessor :valid_records, :valid

  def new
    @reminder_import = ReminderImport.new
    @messages = Reminder.new.build_message
    @reminder = Reminder.new
  end

  def review
    @reminder_import = ReminderImport.new(params[:reminder_import], params[:message_id], session)
    @reminder_import.review
  end

  def create
    success = 0
    fail = 0
    @reminder_import = params[:reminder_import]
    @reminder_import.map do |r|
      if save_new_valid_reminders(r[1], "complete").is_a? Reminder
        success += 1
      else
        fail += 1
      end
    end
    @success = success
    @fail = fail
    redirect_to reminders_url, notice: "Imported #{pluralize(success, 'reminder')} successfully. #{pluralize(fail, 'failure')}"
  end

  def save_new_valid_reminders(reminders, state)
    recipient = Recipient.where(phone: reminders['phone']).first_or_create
    text_message = Message.find(reminders['message'])
    new_reminder = Reminder.create_new_recipients_reminders(recipient, reminders['send_date'], send_time = '12:00pm', text_message)    
    if new_reminder.is_a? Reminder
      new_reminder.state = state
      new_reminder.session_id = Digest::MD5.hexdigest(Reminder.last.send_date.to_s + @session[:session_id].to_s)
      new_reminder.save
      new_reminder
    end
  end

end