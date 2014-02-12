class Organization < ActiveRecord::Base  
  attr_accessible :name, :user_ids
  has_and_belongs_to_many :users
  validates_presence_of :name

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
end
