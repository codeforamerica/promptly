class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :message_id, :name, :program_id, :report_id, :updated_at
  attr_accessible :programs_attributes, :reports_attributes, :program_ids, :report_ids

  has_one :programs
  has_one :reports
  has_one :messages

  accepts_nested_attributes_for :programs
  accepts_nested_attributes_for :reports
  accepts_nested_attributes_for :messages
end
