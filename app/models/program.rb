class Program < ActiveRecord::Base
  attr_accessible :description, :name, :report_ids, :report_id

  has_many :reports
  has_many :messages, :through => :reports
  has_and_belongs_to_many :recipients
  
  accepts_nested_attributes_for :reports, :allow_destroy => true
  attr_accessible :recipient_ids
end
