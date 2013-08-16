class Reminder < ActiveRecord::Base
  attr_accessible :recipient_id, :message_id, :send_date, :job_id, :name, :reminder, :recipient, :message_text
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id
  attr_accessible :id, :created_at, :updated_at
  # validates :reminder_id, presence: true
  # validates :recipient_id, presence: true
  # validates :send_date, presence: true
  
  belongs_to :recipient
  belongs_to :message
  accepts_nested_attributes_for :message

  def date_format(human_date)
  	human_date.date.to_s(:input_format) 
  end

  def self.grouped_reminders
    Reminder.where('send_date IS NOT NULL', :order => "send_date").to_set.classify {|reminder| reminder.batch_id}
  end

  def self.create_new_recipients_deliveries(recipient, send_date, send_time = '12:00pm', message)
    unless recipient == ""
      reminder_time = Time.zone.parse(send_time)
      reminder_time = reminder_time.getutc
      reminder_date = DateTime.parse(send_date).change(hour: reminder_time.strftime('%H').to_i, min: reminder_time.strftime('%M').to_i)
      @reminder = Reminder.new(:recipient_id => recipient.id, :message_id => message.id)
      @reminder.send_date = reminder_date 
      @reminder.send_time = reminder_time     
      @reminder.batch_id = Digest::MD5.hexdigest(@reminder.message_id.to_s + @reminder.send_date.to_s)
      @reminder.save
      add_reminder_to_queue(@reminder)
      @reminder
    end
  end

  def self.add_reminder_to_queue(reminder)
    theDate = reminder.send_date
    @recipient = Recipient.find(reminder.recipient_id)
    if theDate < DateTime.now
      Notifier.delay(priority: 0, run_at: DateTime.now).perform(@recipient, Message.find(reminder.message_id).message_text)
    else
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(@recipient, Message.find(reminder.message_id).message_text)
      reminder.update_attributes(job_id: theJob.id)
    end
  end

  def self.check_for_valid_date(the_date)
    DateTime.parse(the_date)
  end
end