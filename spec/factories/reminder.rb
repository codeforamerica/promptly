# spec/factories/contacts.rb
FactoryGirl.define do
  factory :reminder do
    name "test reminder"
		reports {[FactoryGirl.create(:report)]}
    programs {[FactoryGirl.create(:program)]}
    # recipients {[FactoryGirl.create(:recipient)]}
  end
end