class Notification < ActiveRecord::Base
	attr_accessible :recipient_id, :reminder_id, :send_date
  belongs_to :recipient
  belongs_to :reminder
end