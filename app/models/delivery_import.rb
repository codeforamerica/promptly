class DeliveryImport
  # https://github.com/railscasts/396-importing-csv-and-excel/blob/master/
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_delivery.map(&:valid?).all?
      imported_delivery.each(&:save!)
      true
    else
      imported_delivery.each_with_index do |delivery, index|
        delivery.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_delivery
    @imported_delivery ||= load_imported_delivery
  end

  def load_imported_delivery
    spreadsheet = open_spreadsheet
    binding.pry
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      delivery = Delivery.find_by_id(row["id"]) || Delivery.new
      delivery.attributes = row.to_hash.slice(*Delivery.accessible_attributes)
      delivery
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
end