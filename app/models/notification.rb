class Notification < ActiveRecord::Base
	attr_accessible :recipient_id, :report_id, :send_date, :job_id
  belongs_to :recipient
  belongs_to :report
end