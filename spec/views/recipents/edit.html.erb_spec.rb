require 'spec_helper'

describe "recipents/edit" do
  before(:each) do
    @recipent = assign(:recipent, stub_model(Recipent,
      :phone => "",
      :case => "",
      :active => false
    ))
  end

  it "renders the edit recipent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recipents_path(@recipent), :method => "post" do
      assert_select "input#recipent_phone", :name => "recipent[phone]"
      assert_select "input#recipent_case", :name => "recipent[case]"
      assert_select "input#recipent_active", :name => "recipent[active]"
    end
  end
end
