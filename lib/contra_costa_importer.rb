require 'csv'
require 'pry'

# Imports CSV dumps given to us by Contra Costa County.
class ContraCostaImporter
  attr_accessor :content

  # What organization should these appointments be imported into?
  ORGANIZATION_ID = 1

  # Keys are a combo of a message code from CalWIN and a language code.
  # Values are message ID's in the Promptly DB.
  # `nil` means we don't know the message id yet.
  MESSAGE_MAP = {
    '100EN' => 22,
    '300EN' => nil,
    '100SP' => 20,
    '300SP' => nil
  }

  DATE_FORMAT = '%F %H:%M:%S'

  def initialize(path)
    @content = File.read(path)
    puts "New importer built."
    import
  end

  def csv_data
    @csv_data ||= CSV.new(@content, headers: true, header_converters: :symbol).entries
  end

  def import
    csv_data.map { |x| build_reminder(x) }
  end

  def build_reminder(appointment)
    recipient = Recipient.where(phone: appointment[:phone_nbr]).first_or_create
    recipient.name = appointment[:case] # Keep the case number in the name field.
    recipient.save!

    group = Group.where(name: build_group_name(appointment[:appt_datetime])).first_or_create
    group.description = 'Built automatically by The Importer.'
    Group.add_phone_numbers_to_group(appointment[:phone_nbr], group)
    group.save!

    message = get_message(appointment)
    
    # TODO(christianbryan@gmail.com): There could be some serious time zone issues here.
    date = Time.strptime(DATE_FORMAT, appointment[:appt_datetime])
    # reminder = Reminder.where(name: 'Importer Job', organization_id: ORGANIZATION_ID).first_or_create
    # reminder.send_date = date
    # reminder.send_time = date

    Reminder.create_new_reminders(message, date, group_id: group.id, organization: ORGANIZATION_ID)

    puts group.inspect
  end

  def build_group_name(date)
    "Imported: #{date}"
  end

  def get_message(appointment)
    Message.where(name: appointment[:mssg_cd] + appointment[:language]).first_or_create
  end
end
