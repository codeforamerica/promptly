class Program < ActiveRecord::Base
  attr_accessible :description, :name, :report_ids, :report_id

  has_many :reports, :dependent => :destroy
  has_many :messages, :through => :reports, :dependent => :destroy
  has_and_belongs_to_many :recipients
  
  attr_accessible :recipient_ids
end
