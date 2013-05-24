class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_ids, :recipients_attributes, :program_ids
  has_and_belongs_to_many :recipients
  has_many :programs, :through => :recipients
  has_many :messages
  accepts_nested_attributes_for :messages
  attr_accessible :message_attributes
end
