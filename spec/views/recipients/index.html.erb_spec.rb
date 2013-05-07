require 'spec_helper'

describe "recipients/index" do
  before(:each) do
    assign(:recipients, [
      stub_model(Recipient,
        :phone => "",
        :case => "",
        :active => false
      ),
      stub_model(Recipient,
        :phone => "",
        :case => "",
        :active => false
      )
    ])
  end

  it "renders a list of recipients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
