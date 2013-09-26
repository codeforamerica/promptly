# spec/factories/contacts.rb
require 'factory_girl'

FactoryGirl.define do
  factory :recipient do
  	name "test"
    phone "9196361635"
  end
end