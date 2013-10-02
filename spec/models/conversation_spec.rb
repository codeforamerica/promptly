require 'spec_helper'

describe Conversation do
  describe "grouped_sent_conversations" do
    it "returns a list of sent messages" do
      conversation = FactoryGirl.create(:conversation, status: "sent")
      Conversation.grouped_sent_conversations.count.should == 1
    end
  end
end
