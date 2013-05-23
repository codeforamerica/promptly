class Message < ActiveRecord::Base
  attr_accessible :message, :report_id, :send_date, :type
  belongs_to :reports
  has_many :recipients
end
