require 'csv'
require 'pry'

# Imports CSV dumps given to us by Contra Costa County.
class ContraCostaImporter
  attr_accessor :content

  # Keys are a combo of a message code from CalWIN and a language code.
  # Values are message ID's in the Promptly DB.
  # `nil` means we don't know the message id yet.
  MESSAGE_MAP = {
    '100EN' => 22,
    '300EN' => nil,
    '100SP' => 20,
    '300SP' => nil
  }

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

    puts group.inspect
  end

  def build_group_name(date)
    "Imported: #{date}"
  end
end
