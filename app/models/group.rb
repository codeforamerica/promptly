class Group < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :group_id, :description, :group_name_id, :editable, :active
  attr_accessible :recipient_ids, :recipient_attributes, :reminder_ids, :reminder_attributes
  has_and_belongs_to_many :reminders
  has_and_belongs_to_many :recipients
  accepts_nested_attributes_for :recipients

  def self.add_phone_numbers_to_group(phone_numbers, the_group)
    phones_to_group = []
    phone_numbers.split(/[ ,;\r\n]/).each do |phone_number|
      recipient = Recipient.where(phone: phone_number).first_or_create
      recipient.save
      unless recipient == ""
        phones_to_group << recipient.id
      end
    end
    the_group.recipient_ids = phones_to_group
  end

  def self.add_reminders_to_group(reminder, group)
    group.reminders << reminder
  end

  #Add an array of phone numbers to a group
  def add_phone_number_array(phone_numbers)
    new_recipients = []
    phone_numbers.each do |p|
      r = Recipient.where(phone: p).first_or_create
      r.save
      r.empty? ? r : new_recipients << r.id
    end
    self.recipients = new_recipients
  end
end