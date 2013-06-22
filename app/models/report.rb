class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_id, :program_id, :reminder_id, :message_id
  attr_accessible :message_attributes
  
  has_many :reminders
  belongs_to :programs
  has_many :message, :dependent => :destroy

  accepts_nested_attributes_for :message

end
