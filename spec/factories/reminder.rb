# spec/factories/contacts.rb
FactoryGirl.define do
  factory :reminder do
    name "test reminder"
    message_text "test reminder"
    recipients {|t| [t.association(:recipient)] }
  end
end