class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :message_text
  attr_accessible :program_id, :report_id, :report_attributes

  belongs_to :program
  belongs_to :report

  accepts_nested_attributes_for :program
  accepts_nested_attributes_for :report
end
