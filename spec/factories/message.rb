# spec/factories/message.rb
FactoryGirl.define do
  factory :message do
    message_type "QR7first"
	message_text "message text message text message text"
  end
end