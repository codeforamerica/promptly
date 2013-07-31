class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :message_text
  has_many :recipients, through: :deliveries
end
