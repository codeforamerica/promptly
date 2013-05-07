require 'spec_helper'

describe "programs/new" do
  before(:each) do
    assign(:program, stub_model(Program,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new program form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => programs_path, :method => "post" do
      assert_select "input#program_name", :name => "program[name]"
      assert_select "textarea#program_description", :name => "program[description]"
    end
  end
end
