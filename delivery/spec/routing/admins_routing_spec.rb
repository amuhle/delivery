require "spec_helper"

describe AdminsController do
  describe "routing" do

    it "routes to #index" do
      get("/admins").should route_to("admins#index")
    end

    it "routes to #new" do
      get("/admins/new").should route_to("admins#new")
    end

    it "routes to #show" do
      get("/admins/1").should route_to("admins#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admins/1/edit").should route_to("admins#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admins").should route_to("admins#create")
    end

    it "routes to #update" do
      put("/admins/1").should route_to("admins#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admins/1").should route_to("admins#destroy", :id => "1")
    end

  end
end
