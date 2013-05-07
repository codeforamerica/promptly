require "spec_helper"

describe ConversationsController do
  describe "routing" do

    it "routes to #index" do
      get("/conversations").should route_to("conversations#index")
    end

    it "routes to #new" do
      get("/conversations/new").should route_to("conversations#new")
    end

    it "routes to #show" do
      get("/conversations/1").should route_to("conversations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/conversations/1/edit").should route_to("conversations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/conversations").should route_to("conversations#create")
    end

    it "routes to #update" do
      put("/conversations/1").should route_to("conversations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/conversations/1").should route_to("conversations#destroy", :id => "1")
    end

  end
end
