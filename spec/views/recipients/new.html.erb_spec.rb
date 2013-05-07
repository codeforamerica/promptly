require 'spec_helper'

describe "recipients/new" do
  before(:each) do
    assign(:recipient, stub_model(Recipient,
      :phone => "",
      :case => "",
      :active => false
    ).as_new_record)
  end

  it "renders new recipient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recipients_path, :method => "post" do
      assert_select "input#recipient_phone", :name => "recipient[phone]"
      assert_select "input#recipient_case", :name => "recipient[case]"
      assert_select "input#recipient_active", :name => "recipient[active]"
    end
  end
end
