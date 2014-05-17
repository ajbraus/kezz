require "spec_helper"

describe PoemsController do
  describe "routing" do

    it "routes to #index" do
      get("/poems").should route_to("poems#index")
    end

    it "routes to #new" do
      get("/poems/new").should route_to("poems#new")
    end

    it "routes to #show" do
      get("/poems/1").should route_to("poems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/poems/1/edit").should route_to("poems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/poems").should route_to("poems#create")
    end

    it "routes to #update" do
      put("/poems/1").should route_to("poems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/poems/1").should route_to("poems#destroy", :id => "1")
    end

  end
end
