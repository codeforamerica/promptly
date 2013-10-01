FactoryGirl.define do
  factory :user do
	  email                  "admin@email.com"
	  password               "password"
	  password_confirmation  "password"
	  roles					 "admin"
	  name					 "test"
	end
end