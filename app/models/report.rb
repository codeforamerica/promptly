class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_id, :program_id, :reminder_id
  attr_accessible :recipient_attributes, :messages_attributes
  
  belongs_to :reminders
  belongs_to :programs
  has_many :messages, :dependent => :destroy

  accepts_nested_attributes_for :messages

end
