class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number, :message_id
  has_and_belongs_to_many :recipients
  has_many :reports
  has_many :programs

  attr_accessible :recipient_ids
  attr_accessible :conversation_ids
end
