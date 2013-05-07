require "spec_helper"

describe ProgramsController do
  describe "routing" do

    it "routes to #index" do
      get("/programs").should route_to("programs#index")
    end

    it "routes to #new" do
      get("/programs/new").should route_to("programs#new")
    end

    it "routes to #show" do
      get("/programs/1").should route_to("programs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/programs/1/edit").should route_to("programs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/programs").should route_to("programs#create")
    end

    it "routes to #update" do
      put("/programs/1").should route_to("programs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/programs/1").should route_to("programs#destroy", :id => "1")
    end

  end
end
