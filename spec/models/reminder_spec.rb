require 'spec_helper'

describe Reminder do
	it "has a valid factory" do
    FactoryGirl.create(:reminder).should be_valid
  end

  describe 'check_for_existing_reminder' do
  	context 'given an existing reminder' do
  		it 'returns true' do
  			# Reminder.check_for_existing_reminder(recipient_check, reminder_time, message_check)
  		end
	  end
	  context 'given a new reminder' do
	  	it 'returns false'
	  end
	end
end
