# spec/factories/message.rb
FactoryGirl.define do
  factory :message do
    name "test message"
    message_text "test"
    description "this is a test message"
  end
end