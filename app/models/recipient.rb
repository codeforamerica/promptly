class Recipient < ActiveRecord::Base
  attr_accessible :name, :phone, :reminder_ids, :conversation_ids, :group_ids, :organization_ids
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :conversations
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :organizations
  has_many :reminders
  has_many :messages, :through => :reminders

  accepts_nested_attributes_for :messages
  validates :phone, :presence => true

  def phone_or_name
    name ? "#{name}" : "#{phone}"
  end

end
