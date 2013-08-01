# spec/factories/contacts.rb
FactoryGirl.define do
	factory :delivery do
	    association :recipient
	    association :reminder
	end
end