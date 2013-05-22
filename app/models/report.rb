class Report < ActiveRecord::Base
  attr_accessible :humanname, :report_type, :recipient_ids, :recipient_attributes
  has_and_belongs_to_many :recipients
  has_many :programs, :through => :recipients
end
