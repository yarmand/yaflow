require "spec_helper"

describe ShootingsController do
  describe "routing" do

    it "routes to #index" do
      get("/shootings").should route_to("shootings#index")
    end

    it "routes to #new" do
      get("/shootings/new").should route_to("shootings#new")
    end

    it "routes to #show" do
      get("/shootings/1").should route_to("shootings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shootings/1/edit").should route_to("shootings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shootings").should route_to("shootings#create")
    end

    it "routes to #update" do
      put("/shootings/1").should route_to("shootings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shootings/1").should route_to("shootings#destroy", :id => "1")
    end

  end
end
