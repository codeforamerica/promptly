require 'spec_helper'

describe GroupsController do
	describe "GET index" do
    it "shows the groups" do
      group = FactoryGirl.create(:group, name: 'group 1', description: 'the test group')
      get :index
      response.should be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

end