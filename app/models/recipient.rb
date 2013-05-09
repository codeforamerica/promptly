class Recipient < ActiveRecord::Base
  attr_accessible :active, :case, :phone, :reports_attributes
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :programs
  has_and_belongs_to_many :conversations
  
  attr_accessible :report_ids
end
