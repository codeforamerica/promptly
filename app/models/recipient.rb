class Recipient < ActiveRecord::Base
  attr_accessible :name, :phone
  has_and_belongs_to_many :reminders
  has_and_belongs_to_many :conversations
  has_many :notifications, :dependent => :destroy
  has_many :deliveries
  has_many :reminders, :through => :deliveries

  attr_accessible :reminder_ids
  attr_accessible :conversation_ids
  attr_accessible :notification_ids, :notifications_attributes

  accepts_nested_attributes_for :notifications, :allow_destroy => true
  accepts_nested_attributes_for :reminders

  validates :phone, :presence => true

  def phone_or_name
    name ? "#{name}" : "#{phone}"
  end

  def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      formatDate = Date.strptime(row["reminder_date"], '%m/%d/%Y')
      @report = Report.where(report_type: row['report_type']).first_or_initialize
      recipient = where(phone: row["phone"])
        .first_or_create(row.to_hash.slice(*accessible_attributes))
      #assign related reports to our current report
      @notification = Notification.where(reminder_id: @report.reminder_id, recipient_id: recipient.id).first_or_initialize
      # binding.pry
      if recipient.reports.blank?
        recipient.reports <<  @report
      else 
        unless recipient.reports.any? {|h| h[:id] == @report.id}
            recipient.reports << @report
          end
      end

      if recipient.notifications.blank?
        @notification.sent_date = formatDate
        recipient.notifications << @notification
        sendNotification(formatDate, @report, recipient)
      else
        recipient.notifications.each do |notification|
          if notification.reminder_id == @report.id && notification.sent_date.strftime('%m/%d/%Y') != formatDate.strftime('%m/%d/%Y')
            notification.update_column('sent_date', formatDate)
            sendNotification(formatDate, @report, recipient)
          elsif notification.reminder_id != @report.id
            @notification.sent_date = formatDate
            recipient.notifications << @notification
            sendNotification(formatDate, @report, recipient)
          end
        end
      end
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
		  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
		  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
		  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
		  else raise "Unknown file type: #{file.original_filename}"
	  end
	end
  
  def self.sendNotification(notification, report, recipient)
    # binding.pry
    # if notification < DateTime.now
    #   Notifier.delay(priority: 1, run_at: DateTime.now).perform(recipient, Reminder.find_by_report_id(report.id).message_text)
    # else
    #   Notifier.delay(priority: 1, run_at: notification).perform(recipient, Reminder.find_by_report_id(report.id).message_text)
    # end
  end
end
