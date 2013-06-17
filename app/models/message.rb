class Message < ActiveRecord::Base
  attr_accessible :messagetext, :report_id, :send_date, :type, :reminder_id

  belongs_to :reminders
  belongs_to :reports

end
