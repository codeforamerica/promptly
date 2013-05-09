class Notifications < ActiveRecord::Base
  attr_accessible :recipient_id, :report_id, :send_date
  belongs_to :recipient
  belongs_to :report
end
