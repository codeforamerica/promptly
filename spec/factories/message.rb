# spec/factories/contacts.rb

FactoryGirl.define do
  factory :message do
    name "test message"
    message_text "test message"
    description "this is a test message"
  end
end