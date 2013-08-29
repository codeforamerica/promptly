class ReminderImport
  # https://github.com/railscasts/396-importing-csv-and-excel/blob/master/
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file, :valid, :error

  def initialize(attributes = {}, message = '', session = '')
    attributes.each { |name, value| send("#{name}=", value) }
    @message = message
    @session = session
  end

  def persisted?
    false
  end

  def review
    load_uploaded_data
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
      self.valid = Hash.new()
      self.error = Hash.new()
    (2..data.last_row).map do |i|
      row = Hash[[header, data.row(i)].transpose]
      row_valid = Hash.new()
      row_error = Hash.new()
      row['errors'] = []
      row['errors'] = log_validation_errors("send_date", row["send_date"])
      row['message'] = message
      if row['errors'] == false
        save_new_reminders(row, "processing")
      else
        self.error[i] = Hash[row]
      end
    end
  end

  def log_validation_errors(key, value)
    @validation = Reminder.check_for_valid_date(value)
    if @validation.acts_like?(:string)
      @validation
    else
      ''
      false
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

  def save_new_reminders(reminders, state)
    recipient = Recipient.where(phone: reminders['phone']).first_or_create
    text_message = Message.find(reminders['message'])
    new_reminder = Reminder.create_new_recipients_reminders(recipient, reminders['send_date'], send_time = '12:00pm', text_message)    
    if new_reminder.is_a? Reminder
      new_reminder.state = state
      new_reminder.session_id = Digest::MD5.hexdigest(Reminder.last.send_date.to_s + @session[:session_id].to_s)
      new_reminder.save
      new_reminder
    end
  end

  private

  attr_reader :reminder
  def message_id
    @message
  end

end