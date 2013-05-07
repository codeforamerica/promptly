require "spec_helper"

describe RecipentsController do
  describe "routing" do

    it "routes to #index" do
      get("/recipents").should route_to("recipents#index")
    end

    it "routes to #new" do
      get("/recipents/new").should route_to("recipents#new")
    end

    it "routes to #show" do
      get("/recipents/1").should route_to("recipents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recipents/1/edit").should route_to("recipents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recipents").should route_to("recipents#create")
    end

    it "routes to #update" do
      put("/recipents/1").should route_to("recipents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recipents/1").should route_to("recipents#destroy", :id => "1")
    end

  end
end
