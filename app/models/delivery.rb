class Delivery < ActiveRecord::Base
  attr_accessible :recipient_id, :reminder_id, :send_date, :job_id, :name, :reminder, :recipient
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id
  
  belongs_to :recipient
  belongs_to :reminder

  def date_format(human_date)
  	human_date.date.to_s(:input_format) 
  end

  def self.grouped_deliveries
    Delivery.all.to_set.classify {|delivery| delivery.batch_id}
  end

end