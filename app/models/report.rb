class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_ids, :program_id
  attr_accessible :recipient_attributes
  
  belongs_to :reminders
  belongs_to :programs
  has_many :messages, :dependent => :destroy

end
