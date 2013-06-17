class Program < ActiveRecord::Base

  attr_accessible :description, :name, :report_id

  belongs_to :reminders
  has_many :reports, :dependent => :destroy
  has_many :messages, :through => :reports, :dependent => :destroy
  
end
