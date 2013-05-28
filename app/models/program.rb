class Program < ActiveRecord::Base
  attr_accessible :description, :name, :report_ids
  has_many :reports
  has_and_belongs_to_many :recipients

  attr_accessible :recipient_ids
end
