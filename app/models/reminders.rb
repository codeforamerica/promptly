class Reminder < ActiveRecord::Base
  attr_accessible :created_at, :message_id, :name, :program_id, :report_id, :updated_at

  has_and_belongs_to_many :programs
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :messages
end
