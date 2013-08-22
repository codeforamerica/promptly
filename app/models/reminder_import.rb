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

  def review
    @imported_reminder ||= load_uploaded_data
  end

  def save
      binding.pry
    imported_reminder.each do |reminder|
      begin
        if reminder.instance_of? Reminder
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
        else
          @errors.add reminder
        end
      rescue
        # raise ArgumentError.new('Something went wrong. '+$!.message)
        next
      end
    end
  end

  def imported_reminder
    @imported_reminder ||= load_imported_reminder
  end

  def load_uploaded_data
    message = message_id
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    if !header.include?('send_date')
      'You must have a column with named "send_date".'
    else
      create_imported_data_hash(spreadsheet, header, message)
    end
  end

  def create_imported_data_hash(data, header, message)
    (2..data.last_row).map do |i|
      row = Hash[[header, data.row(i)].transpose]
      row['errors'] = []
      row['errors'] = log_validation_errors("send_date", row["send_date"])
      row['message'] = message
      row
    end
    
  end

  def log_validation_errors(key, value)
    @error = Reminder.check_for_valid_date(value)
    if @error.acts_like?(:string)
      @error
    else
      ''
    end
  end

  def load_imported_reminder
    message = message_id
    spreadsheet = open_spreadsheet
     header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      if !row['send_date']
        raise ArgumentError.new('Row #{i+2}: You must have a column named "send_date"')
      end
      recipient = Recipient.where(phone: row['phone']).first_or_create
      text_message = Message.find(message)
      if row['send_time'] 
        reminder_time = row['send_time']
      else
        reminder_time = '12:00pm'
      end
      @new_reminder = Reminder.create_new_recipients_reminders(recipient, row['send_date'], reminder_time, text_message)
      unless @new_reminder.instance_of? Reminder
        @new_reminder = 'Row #{i+2} has an error '+@new_reminder
      end
      # imported_reminder = 'Sorry something went wrong. Row '+i+': '+$!.message
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