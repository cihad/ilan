require "spec_helper"

describe Control::BaseController do
  describe "routing" do

    it "routes to #index" do
      get("control").should route_to("control/base#index")
    end

  end
end
