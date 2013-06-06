class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_ids, :recipient_attributes, :program_id
  has_and_belongs_to_many :recipients
  belongs_to :programs
  has_many :messages
  accepts_nested_attributes_for :messages, :allow_destroy => true
  attr_accessible :messages_attributes
end
