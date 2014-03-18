class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number, :message_id, :status, :batch_id, :call_id, :organization_id, :recipient_ids, :conversation_ids

  has_and_belongs_to_many :recipients
  has_many :reports
  has_many :programs
  belongs_to :organization
  unsubscribed = ["stop", "quit", "unsubscribe", "cancel"]
  
  scope :organization, ->(org_id) { where("organization_id = ?", org_id) }
  scope :calls, where('call_id != ?', 'IS NOT NULL')
  scope :undelivered, where(:status => 'failed')
  scope :all_responses, where(:status => 'received')
  scope :unsubscribed, where('message = ?', unsubscribed)
  scope :grouped_sent_conversations, lambda  { |*limit|
    # Hack to have the lambda take an optional argument.
    limit = limit.empty? ? 0 : limit.first
    if limit != 0
      Conversation.where('status = ?', 'sent')
        .order("date")
        .limit(limit)
        .to_set
        .classify {|reminder| reminder.batch_id}
    else
      Conversation.where('status = ?', 'sent')
        .order("date")
        .to_set
        .classify {|reminder| reminder.batch_id}
    end
  }
end
