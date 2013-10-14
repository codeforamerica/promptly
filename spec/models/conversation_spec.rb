require 'spec_helper'

describe Conversation do
  describe "#grouped_sent_conversations" do
    it "returns a list of sent messages with no limit" 
      # conversation = FactoryGirl.create(:conversation, status: "sent")
      # Conversation.grouped_sent_conversations.count.should == 1

    it "returns a list of sent messages with a limit of 1"
      # conversation = FactoryGirl.create(:conversation, status: "sent")
      # Conversation.grouped_sent_conversations(1).count.should == 1
  end

  describe "#all_responses" do
    it "returns a list of all messages" do
      conversation = FactoryGirl.create(:conversation, status: "received")
      Conversation.all_responses.count.should == 1
    end
  end

  describe "#undelivered" do
    it "returns a list of all undelivered messages" do
      conversation = FactoryGirl.create(:conversation, status: "failed")
      Conversation.undelivered.count.should == 1
    end
  end

end
