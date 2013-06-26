class Program < ActiveRecord::Base

  attr_accessible :description, :name, :report_id, :reminder_id
  attr_accessible :report_attributes, :reminders_attributes, :program_attributes

  has_many :reports, :dependent => :destroy
  has_many :reminders, :through => :reports, :dependent => :destroy

  accepts_nested_attributes_for :reports
  
end
