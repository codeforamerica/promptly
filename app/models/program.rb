class Program < ActiveRecord::Base

  attr_accessible :description, :name, :report_id, :reminder_id
  attr_accessible :report_attributes

  belongs_to :reminders
  has_one :report, :dependent => :destroy
  has_one :message, :through => :reminders, :dependent => :destroy
  
end
