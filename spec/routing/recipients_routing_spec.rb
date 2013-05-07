require "spec_helper"

describe RecipientsController do
  describe "routing" do

    it "routes to #index" do
      get("/recipients").should route_to("recipients#index")
    end

    it "routes to #new" do
      get("/recipients/new").should route_to("recipients#new")
    end

    it "routes to #show" do
      get("/recipients/1").should route_to("recipients#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recipients/1/edit").should route_to("recipients#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recipients").should route_to("recipients#create")
    end

    it "routes to #update" do
      put("/recipients/1").should route_to("recipients#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recipients/1").should route_to("recipients#destroy", :id => "1")
    end

  end
end
