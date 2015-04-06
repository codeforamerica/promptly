class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number, :message_id, :status, :batch_id, :call_id, :organization_id, :recipient_ids, :conversation_ids, :group_id

  has_and_belongs_to_many :recipients
  has_many :reports
  has_many :programs
  belongs_to :organization
  unsubscribed = ["stop", "quit", "unsubscribe", "cancel"]
  subscribed = ["start", "yes"]
  
  scope :organization, ->(org_id) { where("organization_id = ?", org_id) }
  
  scope :all_calls, where('call_id IS NOT NULL and message_id IS NULL')
  scope :year_calls, where("call_id IS NOT NULL and message_id IS NULL and status =? and date >= ?", "completed", "#{Time.now.year}0101")
  scope :month_calls, where("call_id IS NOT NULL and message_id IS NULL and status =? and date >= ?", "completed", DateTime.now - 1.month)

  scope :undelivered, where(:status => 'failed')
  scope :undelivered_month, where("status = ? and date >= ?", "failed", DateTime.now - 1.month)
  scope :delivered_month, where("status = ? and date >= ?", "sent", DateTime.now - 1.month)
  scope :text_responses, where(:status => 'received')
  scope :unsubscribed, where('lower(message) IN (?)', unsubscribed)
  scope :subscribed, where('lower(message) IN (?)', subscribed)
  scope :all_sent, where('status = ?', "sent")
  scope :grouped_sent_conversations, lambda  { |*limit|
    # Hack to have the lambda take an optional argument.
    limit = limit.empty? ? 1000000 : limit.first
      Conversation.where('status = ?', 'sent')
        .order("date DESC")
        .limit(limit)
  }

  scope :unique_calls_last_month, lambda { |org_phone_number|
    where("call_id IS NOT NULL and message_id IS NULL and status =? and date >= ? and to_number = ?", "completed", DateTime.now - 1.month, org_phone_number)
  }

  scope :texts_sent_last_month, lambda { |org_phone_number|
    where("message_id IS NOT NULL and status =? and date >= ? and from_number = ?", "sent", DateTime.now - 1.month, org_phone_number)
  }

  scope :like, ->(search) { where("message ilike ?", '%' + search + '%') }

  scope :date_filter, lambda  { |*args|
   start_date = args[0][:start_date]
   end_date = args[0][:end_date]
   args[0][:start_date].empty? ? start_date = "01/01/1900".to_date : start_date = DateTime.strptime(args[0][:start_date], "%m/%d/%Y")
   args[0][:end_date].empty? ? end_date = Date.today : end_date = DateTime.strptime(args[0][:end_date], "%m/%d/%Y")
   Conversation.where(:date => start_date.beginning_of_day..end_date.end_of_day)
  }

  def self.first_day
    Conversation.order("date").first
  end

  def self.csv_export_stop_start
    @stop = Conversation.unsubscribed
    @start = Conversation.subscribed 
    @filename = "stop-start-#{DateTime.now.strftime('%m_%d_%Y')}.csv"    
    CSV.open("#{Rails.root.to_s}/tmp/#{@filename}", "wb") do |csv| #creates a tempfile csv
      csv << ["Status", "Phone Number", "Date"] #creates the header
      @stop.each do |s| 
        if s.date >= DateTime.now - 1.day           
          csv << ["#{s.message}", "#{s.from_number}", "#{s.date}"] #create new line for each item in collection
        end
      end
      @start.each do |s|  
        if s.date >= DateTime.now - 1.day          
          csv << ["#{s.message}", "#{s.from_number}", "#{s.date}"] #create new line for each item in collection
        end
      end
    end
  end

  def self.to_csv(conversation_data, options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      conversation_data.each do |conversation|
        csv << conversation.attributes.values_at(*column_names)
      end
    end
  end

end
