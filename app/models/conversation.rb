class Conversation < ActiveRecord::Base
  attr_accessible :date, :message
  has_many :recipients
  has_many :reports
  has_many :programs
end
