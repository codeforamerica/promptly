class Recipient < ActiveRecord::Base
  attr_accessible :active, :case, :phone, :reminder_date, :report_attributes
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :conversations
  has_and_belongs_to_many :programs

  attr_accessible :report_ids
  attr_accessible :conversation_ids
  attr_accessible :program_ids

  # validates :phone, :presence => true

  def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    recipient = where(phone: row["phone"])
        .first_or_create!(row.to_hash.slice(*accessible_attributes))
        # binding.pry

      recipient.reports.where(report_type: row['report_name'])
        .first_or_create!(row.to_hash.slice(*recipient.reports.accessible_attributes))
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
end
