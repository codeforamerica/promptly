require 'spec_helper'

describe "reports/edit" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :type => "",
      :humanname => "MyText"
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path(@report), :method => "post" do
      assert_select "input#report_type", :name => "report[type]"
      assert_select "textarea#report_humanname", :name => "report[humanname]"
    end
  end
end
