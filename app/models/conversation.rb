class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number, :message_id, :status, :batch_id, :call_id
  has_and_belongs_to_many :recipients
  has_many :reports
  has_many :programs

  attr_accessible :recipient_ids
  attr_accessible :conversation_ids

  scope :calls, where('call_id != ?', 'IS NOT NULL')
  scope :undelivered, where(:status => 'failed')
  scope :all_responses, where(:status => 'received')
  unsubscribed = ["stop", "quit", "unsubscribe", "cancel"]
  scope :unsubscribed, where('message = ?', unsubscribed)
  scope :grouped_sent_conversations, lambda  { |limit|
     limit ||=0
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
