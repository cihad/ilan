require 'spec_helper'

describe CitiesController do
  describe "routing" do
    it "routes to #show" do
      get("/cities/1").should route_to("cities#show", :id => "1")
    end
  end
end
