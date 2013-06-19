class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :message_id, :name, :program_id, :report_id, :updated_at
  attr_accessible :programs_attributes, :reports_attributes

  has_and_belongs_to_many :programs
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :recipients

  accepts_nested_attributes_for :programs
  accepts_nested_attributes_for :reports, allow_destroy: true
  accepts_nested_attributes_for :messages
end
