class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_id, :program_id, :reminder_id
  
  has_many :reminders, :dependent => :destroy
  belongs_to :program
end
