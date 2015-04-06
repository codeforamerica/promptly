require 'spec_helper'
include ActionDispatch::TestProcess
# Delayed::Worker.delay_jobs = false

describe Notifier do
  before :each do
     @recipient = FactoryGirl.create(:recipient)
   end

  describe "#perform" do
    before do
      @reminder = FactoryGirl.create(:reminder_with_message_and_group)
    end
    it "creates a new text message for all recipients in a group" do
      # Notifier.perform(@reminder.message_id, group_id: @reminder.group_ids, organization_id: @reminder.organization_id)
    end
    it "creates a new text message for all recipients" do
      # Notifier.perform(@reminder.message_id, recipient_id: @reminder.recipient_id)
    end
  end
end
