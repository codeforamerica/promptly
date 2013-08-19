class ReminderImport
  # https://github.com/railscasts/396-importing-csv-and-excel/blob/master/
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {}, message = '')
    attributes.each { |name, value| send("#{name}=", value) }
    @message = message
  end

  def persisted?
    false
  end

  def save
    if imported_reminder.map(&:valid?).all?
      imported_reminder.each(&:save!)
      true
    else
      imported_reminder.each_with_index do |reminder, index|
        reminder.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_reminder
    @imported_reminder ||= load_imported_reminder
  end

  def load_imported_reminder
    message = message_id
    spreadsheet = open_spreadsheet
     header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      recipient = Recipient.where(phone: row['phone']).first_or_create
      text_message = Message.find(message)
      if row['send_time'] 
        reminder_time = row['send_time']
      else
        reminder_time = '12:00pm'
      end
      Reminder.create_new_recipients_reminders(recipient, row['send_date'], reminder_time, text_message)
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  private

  attr_reader :reminder
  def message_id
    @message
  end

end