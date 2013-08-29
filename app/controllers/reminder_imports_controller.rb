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
      if ReminderImport.save_new_reminders(r[1]).is_a? Reminder
        success += 1
      else
        fail += 1
      end
    end
    @success = success
    @fail = fail
    redirect_to reminders_url, notice: "Imported #{pluralize(success, 'reminder')} successfully. #{pluralize(fail, 'failure')}"
  end

end