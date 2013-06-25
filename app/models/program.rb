class Program < ActiveRecord::Base
  attr_accessible :description, :name, :report_id, :reminder_id
  attr_accessible :report_attributes, :reminders_attributes, :program_attributes

  has_many :reminders
  has_one :report, :dependent => :destroy
  has_many :messages, :through => :reminders, :dependent => :destroy
  
end
