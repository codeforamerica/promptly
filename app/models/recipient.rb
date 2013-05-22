class Recipient < ActiveRecord::Base
  attr_accessible :active, :case, :phone, :reminder_date
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :conversations
  has_and_belongs_to_many :programs

  attr_accessible :report_ids
  attr_accessible :conversation_ids
  attr_accessible :program_ids

  # validates :phone, :presence => true
end
