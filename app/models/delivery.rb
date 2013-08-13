class Delivery < ActiveRecord::Base
  attr_accessible :recipient_id, :reminder_id, :send_date, :job_id, :name, :reminder, :recipient
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id
  attr_accessible :id, :created_at, :updated_at
  # validates :reminder_id, presence: true
  # validates :recipient_id, presence: true
  # validates :send_date, presence: true
  
  belongs_to :recipient
  belongs_to :reminder
  accepts_nested_attributes_for :reminder

  def date_format(human_date)
  	human_date.date.to_s(:input_format) 
  end

  def self.grouped_deliveries
    Delivery.where('send_date IS NOT NULL', :order => "send_date").to_set.classify {|delivery| delivery.batch_id}
  end

  def self.create_new_recipients_deliveries(recipient, send_date, send_time = '12:00pm', reminder)
    unless recipient == ""
      delivery_time = Time.zone.parse(send_time)
      delivery_time = delivery_time.getutc
      delivery_date = DateTime.parse(send_date).change(hour: delivery_time.strftime('%H').to_i, min: delivery_time.strftime('%M').to_i)
      @delivery = Delivery.new(:recipient_id => recipient.id, :reminder_id => reminder.id)
      @delivery.send_date = delivery_date 
      @delivery.send_time = delivery_time     
      @delivery.batch_id = Digest::MD5.hexdigest(@delivery.reminder_id.to_s + @delivery.send_date.to_s)
      @delivery.save
      add_delivery_to_queue(@delivery)
      @delivery
    end
  end

  def self.add_delivery_to_queue(delivery)
    theDate = delivery.send_date
    @recipient = Recipient.find(delivery.recipient_id)
    if theDate < DateTime.now
      Notifier.delay(priority: 0, run_at: DateTime.now).perform(@recipient, Reminder.find(delivery.reminder_id).message_text)
    else
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(@recipient, Reminder.find(delivery.reminder_id).message_text)
      delivery.update_attributes(job_id: theJob.id)
    end
  end
end