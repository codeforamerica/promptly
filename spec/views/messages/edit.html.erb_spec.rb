require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :type => "",
      :message => "MyText",
      :report_id => 1
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path(@message), :method => "post" do
      assert_select "input#message_type", :name => "message[type]"
      assert_select "textarea#message_message", :name => "message[message]"
      assert_select "input#message_report_id", :name => "message[report_id]"
    end
  end
end
