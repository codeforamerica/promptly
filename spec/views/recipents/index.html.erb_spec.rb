require 'spec_helper'

describe "recipents/index" do
  before(:each) do
    assign(:recipents, [
      stub_model(Recipent,
        :phone => "",
        :case => "",
        :active => false
      ),
      stub_model(Recipent,
        :phone => "",
        :case => "",
        :active => false
      )
    ])
  end

  it "renders a list of recipents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
