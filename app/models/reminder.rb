class Reminder < ActiveRecord::Base
  attr_accessible :recipient_id, :message_id, :send_date, :job_id, :name, :reminder, :recipient, :message_text
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id, :group_ids, :state, :session_id
  attr_accessible :id, :created_at, :updated_at
  validates_presence_of :message_id, :send_date, :send_time
  
  belongs_to :recipient
  belongs_to :message
  has_and_belongs_to_many :groups
  accepts_nested_attributes_for :message, :recipient

  def self.grouped_reminders(limit = 0)
    if limit != 0
      Reminder.where('send_date >= ?', DateTime.now)
        .order("send_date")
        .limit(limit)
        .to_set
        .classify {|reminder| reminder.batch_id}
    else
      Reminder.where('send_date >= ?', DateTime.now)
        .order("send_date")
        .to_set
        .classify {|reminder| reminder.batch_id}
    end
  end

  def self.create_new_reminders(message, send_date, options ={})
      defaults = {
        send_time: '12:00pm',
        group_id: nil,
        recipient: nil
      }
      options = defaults.merge(options)

      reminder_time = Time.zone.parse(options[:send_time])
      reminder_time = reminder_time.getutc
      send_date = check_for_valid_date(send_date)
      if options[:recipient]
        the_recipient = options[:recipient].id
      else
        the_recipient = nil
      end
      begin
	      reminder_date = DateTime.parse(send_date.to_s).change(hour: reminder_time.strftime('%H').to_i, min: reminder_time.strftime('%M').to_i)
	      batch_id = Digest::MD5.hexdigest(message.id.to_s + reminder_date.to_s)
        # if check_for_existing_reminder(options[:recipient].id, batch_id)
        #   raise ArgumentError.new("Reminder already exists!")
        # else
          @reminder = Reminder.new(:message_id => message.id)
          @reminder.recipient_id = the_recipient
          @reminder.send_date = reminder_date 
          @reminder.send_time = reminder_time     
          @reminder.batch_id = batch_id
          @reminder.group_ids = options[:group_id]
          @reminder.save!
          @reminder.add_to_queue
          @reminder
        # end
      rescue
        $!.message
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

  def add_to_queue
    theDate = send_date
    if recipient_id
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(message_id, group_id: group_ids, recipient_id: recipient_id)
    else
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(message_id, group_id: group_ids)
    end
    update_attributes(job_id: theJob.id)
    # binding.pry
  end
end

