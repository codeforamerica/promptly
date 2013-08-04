class Delivery < ActiveRecord::Base
  attr_accessible :recipient_id, :reminder_id, :send_date, :job_id
  attr_accessible :reminder_ids
  
  belongs_to :recipient
  belongs_to :reminder

  def date_format(human_date)
  	human_date.date.to_s(:input_format) 
  end

end