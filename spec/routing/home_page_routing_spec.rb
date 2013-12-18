require "spec_helper"

describe HomePageController do
  describe "routing" do

    it "routes to #index" do
      get("/").should route_to("home_page#index")
    end
    
  end
end
