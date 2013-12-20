require "spec_helper"

describe Control::CategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("control/categories").should route_to("control/categories#index")
    end

    it "routes to #new" do
      get("control/categories/new").should route_to("control/categories#new")
    end

    it "routes to #edit" do
      get("control/categories/1/edit").should route_to("control/categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("control/categories").should route_to("control/categories#create")
    end

    it "routes to #update" do
      put("control/categories/1").should route_to("control/categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("control/categories/1").should route_to("control/categories#destroy", :id => "1")
    end

  end
end
