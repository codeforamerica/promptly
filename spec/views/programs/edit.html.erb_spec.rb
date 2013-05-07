require 'spec_helper'

describe "programs/edit" do
  before(:each) do
    @program = assign(:program, stub_model(Program,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit program form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => programs_path(@program), :method => "post" do
      assert_select "input#program_name", :name => "program[name]"
      assert_select "textarea#program_description", :name => "program[description]"
    end
  end
end
