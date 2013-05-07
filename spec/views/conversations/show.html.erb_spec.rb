require 'spec_helper'

describe "conversations/show" do
  before(:each) do
    @conversation = assign(:conversation, stub_model(Conversation,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
