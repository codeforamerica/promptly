class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number, :message_id, :status, :batch_id, :call_id, :organization_id, :recipient_ids, :conversation_ids, :group_id

  has_and_belongs_to_many :recipients
  has_many :reports
  has_many :programs
  belongs_to :organization
  unsubscribed = ["stop", "quit", "unsubscribe", "cancel"]
  
  scope :organization, ->(org_id) { where("organization_id = ?", org_id) }
  
  scope :all_calls, where('call_id IS NOT NULL and message_id IS NULL')
  scope :year_calls, where("call_id IS NOT NULL and message_id IS NULL and status =? and date >= ?", "completed", "#{Time.now.year}0101")
  scope :month_calls, where("call_id IS NOT NULL and message_id IS NULL and status =? and date >= ?", "completed", DateTime.now - 1.month)

  scope :undelivered, where(:status => 'failed')
  scope :undelivered_month, where("status = ? and date >= ?", "failed", DateTime.now - 1.month)
  scope :delivered_month, where("status = ? and date >= ?", "sent", DateTime.now - 1.month)
  scope :text_responses, where(:status => 'received')
  scope :unsubscribed, where('message = ?', unsubscribed)
  scope :all_sent, where('message_id IS NOT NULL')
  scope :grouped_sent_conversations, lambda  { |*limit|
    # Hack to have the lambda take an optional argument.
    limit = limit.empty? ? limit.empty : limit.first
      Conversation.where('status = ?', 'sent')
        .order("date")
        .limit(limit)
  }

  scope :unique_calls_last_month, ->(org_phone_number)  { 
    Conversation.where("call_id IS NOT NULL and message_id IS NULL and status =? and date >= ? and to_number = ?", "completed", DateTime.now - 1.month, org_phone_number).uniq_by(&:from_number)
  }

  def self.first_day
    Conversation.order("date").first
  end
end
