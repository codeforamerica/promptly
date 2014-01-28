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
      orig_responses_count = Conversation.all_responses.count
      response = FactoryGirl.create(:conversation, status: "received")
      conversation = FactoryGirl.create(:conversation)
      Conversation.all_responses.count.should == (1 + orig_responses_count)
    end
  end

  describe "#undelivered" do
    it "returns a list of all undelivered messages" do
      orig_undelivered_count = Conversation.undelivered.count
      undelivered = FactoryGirl.create(:conversation, status: "failed")
      conversation = FactoryGirl.create(:conversation)
      Conversation.undelivered.count.should == (1 + orig_undelivered_count)
    end
  end

    describe "#calls" do
    it "returns a list of calls" do
      orig_call_count = Conversation.calls.count
      call = FactoryGirl.create(:conversation_with_call)
      conversation = FactoryGirl.create(:conversation)
      Conversation.calls.count.should == (1 + orig_call_count)
    end
  end

end
