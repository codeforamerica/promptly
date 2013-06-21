# spec/factories/contacts.rb
FactoryGirl.define do
  factory :recipient do
    phone "9196361635"
		reports {[FactoryGirl.create(:report)]}
  end
end