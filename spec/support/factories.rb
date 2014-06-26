# spec/support/factories.rb
FactoryGirl.define do

  sequence :call_id do |n|
    "test#{n}callID"
  end

  factory :conversation_with_call, parent: :conversation do
    call_id
  end

  factory :conversation do
    date DateTime.now
    message "test message"
    to_number { Faker::PhoneNumber.phone_number }
    from_number { Faker::PhoneNumber.phone_number }
  end

  factory :recipient do
    name "test"
    phone "9196361635"
  end

  factory :group do
    name "test group"
  end

  factory :message do
    name "test message"
    message_text { Faker::Lorem.characters(rand(100..140)) }
    description "this is a test message"
  end

  factory :reminder do
    name "test reminder"
    send_date Date.today
    send_time "12:00pm"
    recipient
    message
  end

  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email # pulls in from the defined sequence
    password "password"
    password_confirmation "password"
    roles "admin"
    name "test"
  end 

  factory :organizations_user do
    roles_mask 1
  end 

  factory :organization do
    name { Faker::Lorem.words(rand(1..4)).join(" ") }
    phone_number {"+14155824309"}
  end

  factory :conversation_with_message, parent: :conversation do
    after :create do 
      conversation.message = FactoryGirl.create(:message)
    end
  end


  factory :reminder_with_message_and_group, parent: :reminder do 
    before :create do |reminder|
      reminder.message = FactoryGirl.create(:message)
      reminder.groups = FactoryGirl.create_list(:group_with_recipient, 1)
      reminder.organization = FactoryGirl.create(:organization)
    end
  end

  factory :reminder_with_message_and_recipient, parent: :reminder do 
    before :create do |reminder|
      reminder.message = FactoryGirl.create(:message)
      reminder.recipient = FactoryGirl.create(:recipient)
    end
  end

  factory :group_with_recipient, parent: :group do
    before :create do |group|
      group.recipients = FactoryGirl.create_list(:recipient, 2)
    end
  end

  factory :group_with_organization, parent: :group do
    before :create do |group|
      group.organization = FactoryGirl.create(:organization)
    end
  end

  factory :user_with_organization, parent: :user do
    after :create do |user|
      user.organizations << FactoryGirl.create(:organization)
    end
  end

  factory :user_with_super, parent: :user_with_organization do
      after :create do |user|
        user.roles << :super
        user.roles_mask = 1
      end
    end
    
end
