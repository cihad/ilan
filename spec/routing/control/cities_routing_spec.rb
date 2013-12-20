require "spec_helper"

describe Control::CitiesController do
  describe "routing" do

    it "routes to #index" do
      get("control/cities").should route_to("control/cities#index")
    end

    it "routes to #new" do
      get("control/cities/new").should route_to("control/cities#new")
    end

    it "routes to #edit" do
      get("control/cities/1/edit").should route_to("control/cities#edit", :id => "1")
    end

    it "routes to #create" do
      post("control/cities").should route_to("control/cities#create")
    end

    it "routes to #update" do
      put("control/cities/1").should route_to("control/cities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("control/cities/1").should route_to("control/cities#destroy", :id => "1")
    end

  end
end
