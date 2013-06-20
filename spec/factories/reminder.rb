# spec/factories/contacts.rb
FactoryGirl.define do
  factory :reminder do
    name "test reminder"
		report {[FactoryGirl.create(:report)]}
    	program {[FactoryGirl.create(:program)]}
    	message {[FactoryGirl.create(:message)]}
    # recipients {[FactoryGirl.create(:recipient)]}
  end
end