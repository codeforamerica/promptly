require 'spec_helper'

describe GroupsController do
  shared_examples "an action that requires login" do
    it "successfully renders the page if the user is logged in" do
      session[:email] = "admin@email.com"
      get action, params
      response.should be_success
    end
  end

	describe "#index" do
    it "shows the group index page" do
      group = FactoryGirl.create(:group, name: 'group 1', description: 'the test group')
      get :index
      response.should be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#update" do
    let(:current_user)    { FactoryGirl.create(:user) }
    let(:action)  { :update }
    let(:params)          { {"group" => {"name" => "group 2", 
                                                   "description" => "a test", 
                                                   "phone" => "9999999999\r\n1111111111"
                                                 }
                                               } }

   it_behaves_like "an action that requires login"
    # before do
    #   update_attributes(users: [current_user])
    # end

    it "updates a group with a new phone number" do
      put :update, params
      # group.reload.name.should == "group 2"
    end
  end

end