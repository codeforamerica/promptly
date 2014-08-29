require 'csv'

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
    '300SP' => nil,
    '200EN' => 30,
    '200SP' => 31
  }

  REPORT_RECIPIENTS = [
    'andy@postcode.io',
    'reed@postcode.io',
    'deisenlohr@ehsd.cccounty.us',
    'rdelavega@ehsd.cccounty.us'
  ]


  DATE_FORMAT = '%F %H:%M:%S'

  def initialize(path)
    @notification_count = Reminder.all.count ||= 0
    @group_count = Group.all.count ||= 0
    @content = File.read(path)
    puts "New importer built."
    import
    @new_notifications = (Reminder.all.count - @notification_count)
    @new_groups = (Group.all.count - @group_count)
    @total_records = csv_data.length
    user = REPORT_RECIPIENTS.collect {|email| User.where(email: email).first_or_create}
    user.each do |u|
      UserNotifier.send_daily_import_log(@total_records, @new_notifications, @new_groups, u).deliver
    end
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

    group = Group.where(name: build_group_name(appointment[:event_datetime])).first_or_create
    group.description = 'Built automatically by The Importer.'
    group.update_attributes(organization_id: ORGANIZATION_ID)
    Group.add_phone_numbers_to_group(appointment[:phone_nbr], group)
    group.save!

    message = get_message(appointment)
    # TODO(christianbryan@gmail.com): There could be some serious time zone issues here.
    date = appointment[:event_datetime].to_datetime
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
    if appointment[:language] != 'SP' && appointment[:language] != 'EN'
      if Message.where(name: appointment[:mssg_cd] + 'EN').empty? && 
        new_message = Message.new(name: appointment[:mssg_cd] + 'EN', message_text: "add a text message here.", organization_id: ORGANIZATION_ID, description: "automatically created")
        new_message.save!
        new_message
      else
        Message.where(name: appointment[:mssg_cd] + 'EN').first_or_create
      end
    else
      if Message.where(name: appointment[:mssg_cd] + appointment[:language]).empty? && 
        new_message = Message.new(name: appointment[:mssg_cd] + appointment[:language], message_text: "add a text message here.", organization_id: ORGANIZATION_ID, description: "automatically created")
        new_message.save!
        new_message
      else
        Message.where(name: appointment[:mssg_cd] + appointment[:language]).first_or_create
      end 
    end
  end
end
