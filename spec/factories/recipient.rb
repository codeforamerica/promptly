# spec/factories/contacts.rb
FactoryGirl.define do
  factory :recipient do
    phone 9196361635
		reports {[FactoryGirl.create(:report)]}
  end
		
  factory :report do
    report_type "Calfresh"
    humanname "a test"
  end
end