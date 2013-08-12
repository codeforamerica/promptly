class Delivery < ActiveRecord::Base
  attr_accessible :recipient_id, :reminder_id, :send_date, :job_id, :name, :reminder, :recipient
  attr_accessible :reminder_ids, :recipient_ids, :send_time, :batch_id
  validates :reminder_id, presence: true
  validates :recipient_id, presence: true
  validates :send_date, presence: true
  
  belongs_to :recipient
  belongs_to :reminder
  accepts_nested_attributes_for :reminder

  def date_format(human_date)
  	human_date.date.to_s(:input_format) 
  end

  def self.grouped_deliveries
    Delivery.where('send_date IS NOT NULL', :order => "send_date").to_set.classify {|delivery| delivery.batch_id}
  end

  def self.import(file, reminder)
    binding.pry
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      formatDate = Date.strptime(row["reminder_date"], '%m/%d/%Y')
      recipient = where(phone: row["phone"])
        .first_or_create(row.to_hash.slice(*accessible_attributes))
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