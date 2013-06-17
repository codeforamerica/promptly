class Message < ActiveRecord::Base
  attr_accessible :messagetext, :report_ids, :send_date, :type
  attr_accessible :program_attributes, :report_attributes

  belongs_to :reminders
  belongs_to :reports

end
