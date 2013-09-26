class Recipient < ActiveRecord::Base
  attr_accessible :name, :phone
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :conversations
  has_and_belongs_to_many :groups
  has_many :reminders
  has_many :messages, :through => :reminders

  attr_accessible :reminder_ids
  attr_accessible :conversation_ids
  attr_accessible :group_ids

  accepts_nested_attributes_for :messages

  validates :phone, :presence => true

  def phone_or_name
    name ? "#{name}" : "#{phone}"
  end

end
