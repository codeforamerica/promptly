class Program < ActiveRecord::Base

  attr_accessible :description, :name, :report_id, :reminder_id

  has_and_belongs_to_many :reminders
  has_many :reports, :dependent => :destroy
  has_many :messages, :through => :reminders, :dependent => :destroy
  
end
