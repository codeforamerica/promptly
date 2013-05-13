class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number
  has_many :recipients
  has_many :reports
  has_many :programs
end
