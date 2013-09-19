class Conversation < ActiveRecord::Base
  attr_accessible :date, :message, :to_number, :from_number, :message_id, :status
  has_and_belongs_to_many :recipients
  has_many :reports
  has_many :programs

  attr_accessible :recipient_ids
  attr_accessible :conversation_ids

  def self.grouped_sent_conversations(limit = 0)
    if limit != 0
      Conversation.where('status = ?', 'sent').order("date").limit(limit).to_set.classify {|reminder| reminder.batch_id}
    else
      Conversation.where('status = ?', 'sent').order("date").to_set.classify {|reminder| reminder.batch_id}
    end
  end

end
