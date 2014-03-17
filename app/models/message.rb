class Message < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :message_text, :description, :recipient_ids, :reminders, :reminders_attributes, :organization_id

  has_many :reminders
  has_many :recipients, :through => :reminders
  belongs_to :organization
  accepts_nested_attributes_for :reminders
  validates :message_text, presence: true

  scope :organization, ->(org_id) { where("organization_id = ?", org_id) }
end
