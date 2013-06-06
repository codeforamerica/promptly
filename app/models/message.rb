class Message < ActiveRecord::Base
  attr_accessible :messagetext, :report_ids, :send_date, :type
  belongs_to :reports
  has_many :recipients
end
