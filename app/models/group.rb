class Group < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :group_id, :description, :group_name_id, :editable, :active
  attr_accessible :recipient_ids, :recipient_attributes, :reminder_ids, :reminder_attributes
  has_and_belongs_to_many :reminders
  has_and_belongs_to_many :recipients
  accepts_nested_attributes_for :recipients

  def self.add_phone_numbers_to_group(phone_numbers, the_group)
    phones_to_group = []
    if phone_numbers.is_a? Array 
      phone_numbers = phone_numbers
    else
      phone_numbers = phone_numbers.split(/[ ,;\r\n]/)
    end
    phone_numbers.each do |phone_number|
      recipient = Recipient.where(phone: phone_number).first_or_create
      recipient.save
      unless recipient == ""
        phones_to_group << recipient.id
      end
    end
    the_group.recipient_ids = phones_to_group
  end

  def self.find_recipients_in_group(group_id)
    Group.find(group_id).recipients
  end
end