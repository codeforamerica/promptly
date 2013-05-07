require 'spec_helper'

describe "recipents/show" do
  before(:each) do
    @recipent = assign(:recipent, stub_model(Recipent,
      :phone => "",
      :case => "",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/false/)
  end
end
