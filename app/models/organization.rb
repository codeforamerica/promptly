class Organization < ActiveRecord::Base  
  attr_accessible :name, :user_ids, :recipient_ids, :conversation_ids, :group_ids, :message_ids, :reminder_ids, :organizations_user, :phone_number
  has_many :organizations_user
  has_many :users, through: :organizations_user
  validates_presence_of :name, :phone_number
  has_many :conversations
  has_many :groups
  has_many :messages
  has_many :reminders

  def to_param
    "#{self.id}"
  end
end
