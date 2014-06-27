require 'spec_helper'

describe Conversation do
  describe "#all_responses" do
    it "returns a list of all received messages" do
      orig_responses_count = Conversation.text_responses.count
      response = FactoryGirl.create(:conversation, status: "received")
      conversation = FactoryGirl.create(:conversation)
      expect(Conversation.text_responses.count).to eq(1 + orig_responses_count)
    end
  end

  describe "#undelivered" do
    it "returns a list of all undelivered messages" do
      orig_undelivered_count = Conversation.undelivered.count
      undelivered = FactoryGirl.create(:conversation, status: "failed")
      conversation = FactoryGirl.create(:conversation)
      expect(Conversation.undelivered.count).to eq(1 + orig_undelivered_count)
    end
  end

    describe "#calls" do
    it "returns a list of calls" do
      orig_call_count = Conversation.all_calls.count
      call = FactoryGirl.create(:conversation_with_call)
      conversation = FactoryGirl.create(:conversation)
      expect(Conversation.all_calls.count).to eq(1 + orig_call_count)
    end
  end

end
