class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_id, :program_id, :reminder_id
  attr_accessible :messages_attributes
  
  belongs_to :reminders
  belongs_to :programs
  has_one :message, :dependent => :destroy

  accepts_nested_attributes_for :message

end
