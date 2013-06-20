class Notification < ActiveRecord::Base
  attr_accessible :recipient_id, :report_id, :sent_date, :job_id, :recipients_attributes

  belongs_to :recipient
  belongs_to :reminder
end