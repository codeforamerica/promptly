class Message < ActiveRecord::Base
  attr_accessible :messagetext, :report_id, :send_date, :type
  belongs_to :report
  has_many :recipients
end
