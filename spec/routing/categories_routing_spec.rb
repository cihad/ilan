require "spec_helper"

describe CategoriesController do
  describe "routing" do

    it "routes to #show" do
      get("/categories/1/page/1").should \
        route_to("categories#show", id: "1", page: "1")
    end
    
  end
end
