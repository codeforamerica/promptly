class Reminder < ActiveRecord::Base
  attr_accessible :recipient_id, :message_id, :send_date, :job_id, :name, :reminder, :recipient, :message_text
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id, :group_ids, :state, :session_id
  attr_accessible :id, :created_at, :updated_at
  # validates :reminder_id, presence: true
  # validates :recipient_id, presence: true
  # validates :send_date, presence: true
  
  belongs_to :recipient
  belongs_to :message
  has_and_belongs_to_many :groups
  accepts_nested_attributes_for :message, :recipient

  def self.grouped_reminders(limit = 0)
    if limit != 0
      Reminder.where('send_date >=?', DateTime.now).order("send_date").limit(limit).to_set.classify {|reminder| reminder.batch_id}
    else
      Reminder.where('send_date >=?', DateTime.now).order("send_date").to_set.classify {|reminder| reminder.batch_id}
    end
  end

  def self.create_new_recipients_reminders(recipient, send_date, send_time = '12:00pm', message)
    unless recipient == ""
      reminder_time = Time.zone.parse(send_time)
      reminder_time = reminder_time.getutc
      send_date = check_for_valid_date(send_date)
      begin
	      reminder_date = DateTime.parse(send_date.to_s).change(hour: reminder_time.strftime('%H').to_i, min: reminder_time.strftime('%M').to_i)
	      batch_id = Digest::MD5.hexdigest(message.id.to_s + reminder_date.to_s)
	      if check_for_existing_reminder(recipient.id, batch_id)
	        raise ArgumentError.new("Reminder already exists!")
		    else
		      @reminder = Reminder.new(:recipient_id => recipient.id, :message_id => message.id)
		      @reminder.send_date = reminder_date 
		      @reminder.send_time = reminder_time     
		      @reminder.batch_id = batch_id
		      @reminder.save
          puts 'saved'
		      add_reminder_to_queue(@reminder)
		      @reminder
		    end
		  rescue
		  	$!.message
		  end
    end
  end

  def self.add_reminder_to_queue(reminder)
    theDate = reminder.send_date
    @recipient = Recipient.find(reminder.recipient_id)
    if theDate < DateTime.now
      Notifier.delay(priority: 0, run_at: DateTime.now).perform(@recipient, Message.find(reminder.message_id).message_text, reminder.batch_id)
    else
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(@recipient, Message.find(reminder.message_id).message_text, reminder.batch_id)
      reminder.update_attributes(job_id: theJob.id)
    end
  end

  def self.check_for_valid_date(the_date)
    begin
      if the_date.is_a? String
        the_date = the_date.gsub("'","").strip
        valid_date = DateTime.strptime(the_date, '%m/%d/%Y')
  			DateTime.parse(valid_date.to_s)
      else
        the_date
      end
		rescue
			'There is an error with the send_date: '+$!.message
		end
  end

  def self.check_for_existing_reminder(recipient_check, batch_id_check)
    phone_check = Recipient.find(recipient_check)
    Reminder.where('batch_id = ? AND recipient_id = ?', batch_id_check, phone_check.id).exists?
  end
end