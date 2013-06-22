class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :message_id, :name, :updated_at
  attr_accessible :program_id, :report_id, :messages_attributes, :report_attributes

  belongs_to :program
  belongs_to :report
  has_many :messages, :through => :report

  accepts_nested_attributes_for :program
  accepts_nested_attributes_for :report
  accepts_nested_attributes_for :messages
end
