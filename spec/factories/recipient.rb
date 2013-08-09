# spec/factories/contacts.rb
FactoryGirl.define do
  factory :recipient do
  	name "test"
    phone "9196361635"
    reminders {|t| [t.association(:reminder)] }
  end
end