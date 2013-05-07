class Recipient < ActiveRecord::Base
  attr_accessible :active, :case, :phone
  has_many :reports
  has_many :programs
  has_many :conversations
end
