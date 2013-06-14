class Message < ActiveRecord::Base
  attr_accessible :messagetext, :report_ids, :send_date, :type
  attr_accessible :program_attributes, :report_attributes

  belongs_to :reports
  belongs_to :programs
  has_many :recipients

  accepts_nested_attributes_for :reports, :programs
end
