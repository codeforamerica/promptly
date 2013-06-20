class Message < ActiveRecord::Base
  attr_accessible :message_text, :report_id, :type, :reminder_id

  belongs_to :reminders
  belongs_to :reports

end
