class Group < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :group_id, :description, :group_name_id, :editable, :active
  has_and_belongs_to_many :reminders
  has_and_belongs_to_many :recipients
  accepts_nested_attributes_for :recipients
end
