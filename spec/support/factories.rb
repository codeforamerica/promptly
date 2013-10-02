# spec/support/factories.rb
FactoryGirl.define do
  factory :group do
    name "test group"
  end

  factory :message do
    name "test message"
    message_text "test"
    description "this is a test message"
  end

  factory :recipient do
    name "test"
    phone "9196361635"
  end

  factory :reminder do
    name "test reminder"
    message_id = FactoryGirl.create(:message).id
    send_date Date.today
    send_time "12:00pm"
  end

  factory :user do
    email "example@email.com"
    password "password"
    password_confirmation "password"
    roles "admin"
    name "test"
  end

end