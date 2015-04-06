class Reminder < ActiveRecord::Base
  attr_accessible :recipient_id, :message_id, :send_date, :job_id, :name, :reminder, :recipient, :message_text, :reminder_ids, :recipient_ids, :send_time, :batch_id, :group_ids, :state, :session_id, :id, :created_at, :updated_at, :organization_id

  validates_presence_of :message_id, :send_date, :send_time
  belongs_to :recipient
  belongs_to :message
  belongs_to :organization
  has_and_belongs_to_many :groups
  accepts_nested_attributes_for :message, :recipient

  scope :organization, ->(org_id) { where("organization_id = ?", org_id) }

  scope :upcoming, lambda  { |*limit|
    # Hack to have the lambda take an optional argument.
    # @reminders = []
    limit = limit.empty? ? 10000000 : limit.first
    upcoming_reminders = Reminder.where('send_date >= ?', DateTime.now.utc)
      .order("send_date")
    upcoming_reminders.each do |reminder|
      if reminder.send_date.utc < DateTime.now.utc
        upcoming_reminders.delete(reminder)
      end
    end
    upcoming_reminders.limit(limit)
  }

  scope :group_upcoming, ->(org_id, group_id) {joins(:groups).where("groups.organization_id = ? AND groups.id = ?", org_id, group_id) & Reminder.upcoming}

  def self.grouped_reminders(limit = 0)
    if limit != 0
      Reminder.where('send_date >= ?', DateTime.now)
        .order("send_date")
        .limit(limit)
        .to_set
    else
      Reminder.where('send_date >= ?', DateTime.now)
        .order("send_date")
        .to_set
    end
  end

  def self.create_new_reminders(message, send_date, options ={})
      defaults = {
        send_time: '12:00pm',
        group_id: nil,
        recipient: nil,
        organization_id: nil
      }
      options = defaults.merge(options)

      reminder_time = Time.zone.parse(options[:send_time])
      send_date = check_for_valid_date(send_date)
      if options[:recipient]
        the_recipient = options[:recipient].id
      else
        the_recipient = nil
      end
      begin
        reminder_date = DateTime.new(send_date.year, send_date.month, send_date.day, reminder_time.hour, reminder_time.min, reminder_time.sec, reminder_time.zone).getutc
        @reminders = Reminder.includes(:groups, :organization, :message).where(:groups => {id: options[:group_id]}, organization_id: options[:organization_id], message_id: message.id)
        if @reminders.empty?
          @reminder = Reminder.new(message_id: message.id)
          @reminder.create_and_save_reminder(the_recipient, reminder_time, reminder_date, options)
          @reminder.save!
          if @reminder.job_id.nil?
            @reminder.add_to_queue
          end
        else
          @reminder = Reminder.includes(:groups, :organization, :message).where(:groups => {id: options[:group_id]}, organization_id: options[:organization_id], message_id: message.id, send_date: reminder_date.to_datetime).first_or_create
          @reminder.create_and_save_reminder(the_recipient, reminder_time, reminder_date, options)
          @reminder.save!
          if @reminder.job_id.nil?
            @reminder.add_to_queue
          end
        end
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

  def create_and_save_reminder(the_recipient, reminder_time, reminder_date, options)
    update_attributes(recipient_id: the_recipient)
    update_attributes(send_date: reminder_date)
    update_attributes(send_time: reminder_time) 
    update_attributes(group_ids: options[:group_id]) 
    update_attributes(organization_id: options[:organization_id])  
  end

  def add_to_queue
    theDate = send_date
    if recipient_id
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(message_id, group_id: group_ids, recipient_id: recipient_id, organization_id: organization_id)
    else
      theJob = Notifier.delay(priority: 0, run_at: theDate).perform(message_id, group_id: group_ids, organization_id: organization_id)
    end
    update_attributes(job_id: theJob.id)
  end
end

