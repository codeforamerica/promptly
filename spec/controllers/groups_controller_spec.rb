require 'spec_helper'

describe GroupsController do
    before :each do
       @user = FactoryGirl.create(:user)
    end
  shared_examples "an action that requires login" do
    it "successfully renders the page if the user is logged in" do
      # session[:email] = "admin@email.com"

      visit new_user_session_path

      fill_in "Email",    :with => @user.email
      fill_in "Password", :with => @user.password

      click_button "Sign in"
      get action, params
      response.should be_success
    end
  end

	describe "#index" do
    let(:action)  { :index }
    let(:params) { {} }

    it_behaves_like "an action that requires login"

    it "shows the group index page" do
      group = FactoryGirl.create(:group, name: 'group 1', description: 'the test group', id: 1)
      get :index
      response.should be_success
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#edit" do
    let(:current_user)    { @user }
    let(:action)  { :edit }
    let(:params) { {"id"=>1} }
    before do
      group = FactoryGirl.create(:group, name: 'group 1', description: 'the test group', id: 1)
    end

    it_behaves_like "an action that requires login"

     it "renders the edit template" do
      get :edit, :id => 1
      expect(response).to render_template("edit")
    end
  end

  describe "#update" do
    group = FactoryGirl.create(:group, name: 'group 1', description: 'the test group', id: 1)
    let(:current_user)    { @user }
    let(:action)  { :update }
    let(:params)          { {"group" => {"name" => "group 2", 
                                                   "description" => "a test", 
                                                   "phone" => "9999999999\r\n1111111111"
                                                 },
                                                 "id" => 1
                                               } }
    before do
      controller.stub(:current_user).and_return(current_user)
    end

   it_behaves_like "an action that requires login"

   it "renders the edit template" do
      get :edit
      expect(response).to render_template("edit")
    end
    # before do
    #   update_attributes(users: [current_user])
    # end

    it "updates a group with a new phone number" do
      put :update, params
      group.reload.name.should == "group 2"
    end
  end

end