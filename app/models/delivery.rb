class Delivery < ActiveRecord::Base
  attr_accessible :recipient_id, :reminder_id, :send_date, :job_id, :name, :reminder, :recipient
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id
  validates :reminder_id, presence: true
  validates :recipient_id, presence: true
  validates :send_date, presence: true
  
  belongs_to :recipient
  belongs_to :reminder
  accepts_nested_attributes_for :reminder

  def date_format(human_date)
  	human_date.date.to_s(:input_format) 
  end

  def self.grouped_deliveries
    Delivery.where('send_date IS NOT NULL', :order => "send_date").to_set.classify {|delivery| delivery.batch_id}
  end

end