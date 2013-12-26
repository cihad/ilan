require "spec_helper"

describe Control::NodesController do
  describe "routing" do

    it "routes to #index" do
      get("control/nodes").should route_to("control/nodes#index")
    end

    it "routes to #update" do
      put("control/nodes/1").should route_to("control/nodes#update", :id => "1")
    end

  end
end
