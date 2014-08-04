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
    @csv_data ||= CSV.new(@content, headers: false).entries
  end

  def import
    csv_data.map { |x| build_reminder(x) }
  end

  def build_reminder(appointment)
    recipient = Recipient.where(phone: appointment[1]).first_or_create
    recipient.name = appointment[0] # Keep the case number in the name field.
    recipient.save!

    group = Group.where(name: build_group_name(appointment[5])).first_or_create
    group.description = 'Built automatically by The Importer.'
    group.update_attributes(organization_id: ORGANIZATION_ID)
    Group.add_phone_numbers_to_group(appointment[1], group)
    group.save!

    message = get_message(appointment)
    # TODO(christianbryan@gmail.com): There could be some serious time zone issues here.
    date = appointment[5].to_datetime
    date = Time.use_zone('Pacific Time (US & Canada)') { Time.zone.local_to_utc(date) }
    time = date.strftime('%T')
    Reminder.create_new_reminders(message, date, group_id: group.id, organization_id: ORGANIZATION_ID, send_time: time)
    puts Reminder.last.inspect
    puts group.inspect
  end

  def build_group_name(date)
    "Imported: #{date}"
  end

  def get_message(appointment)
    if Message.where(name: appointment[4] + appointment[6]).empty?
      new_message = Message.new(name: appointment[4] + appointment[6], message_text: "add a text message here.", organization_id: ORGANIZATION_ID, description: "automatically created")
      new_message.save!
      new_message
    else
      Message.where(name: appointment[4] + appointment[6]).first_or_create
    end
  end
end
