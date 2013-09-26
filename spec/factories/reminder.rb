# spec/factories/contacts.rb

require 'spec_helper'

FactoryGirl.define do
  factory :reminder do
    name "test reminder"
    message_id = FactoryGirl.create(:message).id
    send_date Date.today
    send_time "12:00pm"
  end
end