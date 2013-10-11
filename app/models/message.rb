class Message < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :message_text, :description, :recipient_ids, :reminders, :reminders_attributes
  has_many :reminders
  has_many :recipients, :through => :reminders
  accepts_nested_attributes_for :reminders
  validates :message_text, presence: true

  def self.search(search)
    binding.pry
    if search
      where('message_text LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
