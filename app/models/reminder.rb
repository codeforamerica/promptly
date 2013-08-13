class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :message_text, :description, :recipient_ids, :deliveries, :deliveries_attributes
  has_many :deliveries
  has_many :recipients, :through => :deliveries
  accepts_nested_attributes_for :deliveries
  validates :message_text, presence: true
end
