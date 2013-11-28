require "spec_helper"

describe NodesController do
  describe "routing" do

    it "routes to #new" do
      get("/nodes/new").should route_to("nodes#new")
    end

    it "routes to #show" do
      get("/nodes/1").should route_to("nodes#show", :id => "1")
    end

    it "routes to #create" do
      post("/nodes").should route_to("nodes#create")
    end
  end
end
