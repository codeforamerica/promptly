require 'spec_helper'

describe "recipients/edit" do
  before(:each) do
    @recipient = assign(:recipient, stub_model(Recipient,
      :phone => "",
      :case => "",
      :active => false
    ))
  end

  it "renders the edit recipient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recipients_path(@recipient), :method => "post" do
      assert_select "input#recipient_phone", :name => "recipient[phone]"
      assert_select "input#recipient_case", :name => "recipient[case]"
      assert_select "input#recipient_active", :name => "recipient[active]"
    end
  end
end
