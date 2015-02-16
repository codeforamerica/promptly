class Group < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :group_id, :description, :group_name_id, :editable, :active, :recipient_ids, :recipient_attributes, :reminder_ids, :reminder_attributes, :organization_id

  has_and_belongs_to_many :reminders
  has_and_belongs_to_many :recipients
  accepts_nested_attributes_for :recipients
  belongs_to :organization

  scope :organization, ->(org_id) { where("organization_id = ?", org_id) }

  def self.add_phone_numbers_to_group(phone_numbers, the_group)
    if phone_numbers.is_a? Array
      phone_numbers = phone_numbers
    else
      phone_numbers = phone_numbers.split(/[ ,;\r\n]/)
    end
    phones_to_group = []
    phone_numbers.each do |phone_number|
      if phone_number.present? && phone_number.to_i >= 1
        phone = PhonyRails.normalize_number(phone_number, :country_code => 'US')
        recipient = Recipient.where(phone: phone).first_or_create
        recipient.save!
        if !recipient.nil?
          phones_to_group << recipient.id
        end
      end
    end
    the_group.recipient_ids = phones_to_group
    the_group.save!
  end

  def self.find_recipients_in_group(group_id)
    Group.find(group_id).recipients
  end
end