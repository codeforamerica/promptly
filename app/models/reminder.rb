class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :message_id, :name, :program_id, :report_id, :updated_at
  attr_accessible :programs_attributes, :reports_attributes, :program_ids, :report_ids
  attr_accessible :message_text, :messages, :messages_attributes

  has_and_belongs_to_many :programs
  has_and_belongs_to_many :reports
  has_many :messages, :through => :reports
  has_and_belongs_to_many :recipients


  accepts_nested_attributes_for :program, :reject_if => lambda { |a| a[:content].blank? }
  accepts_nested_attributes_for :report, :reject_if => lambda { |a| a[:content].blank? }
  accepts_nested_attributes_for :message, :reject_if => lambda { |a| a[:content].blank? }
end
