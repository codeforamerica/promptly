# spec/support/factories.rb
FactoryGirl.define do

  factory :conversation do
    date DateTime.now
    message "test message"
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
    message_text "A test from rspec."
    description "this is a test message"
  end


  factory :reminder do
    name "test reminder"
    send_date Date.today
    send_time "12:00pm"
    recipient FactoryGirl.create(:recipient)
  end

  factory :user do
    email "example@email.com"
    password "password"
    password_confirmation "password"
    roles "admin"
    name "test"
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
    
end