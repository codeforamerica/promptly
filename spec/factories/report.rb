# spec/factories/contacts.rb
FactoryGirl.define do
  factory :report do |f|
    f.report_type "Calfresh"
    f.humanname "a test"
  end
end