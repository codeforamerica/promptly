class Organization < ActiveRecord::Base  
  attr_accessible :name, :user_ids, :recipient_ids, :conversation_ids, :group_ids, :message_ids, :reminder_ids
  has_and_belongs_to_many :users
  has_and_belongs_to_many :recipients
  validates_presence_of :name
  has_many :conversations
  has_many :groups
  has_many :messages
  has_many :reminders
  has_many :organization_users

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
end
