require 'spec_helper'

describe Control::NodesController do

  let(:valid_session) { {  } }
  let!(:node) { create :node }

  before do
    login_as_admin
  end

  describe "GET index" do
    it "assigns nodes as @nodes" do
      status = "test_status"
      filter = double status: status
      nodes  = double
      NodeFilter.stub(:new).with("status" => status).and_return(filter)
      Node.stub(:where).with(status: status).and_return(nodes)

      get :index, { node_filter: { status: status } }, valid_session
      assigns(:nodes).should eq(nodes)
    end
  end

  describe "PUT update" do
    it "updates the requested city" do
      put :update, {:id => node.to_param, :event => "publish"}, valid_session
      expect(assigns :node).to eq(node)
      expect(assigns :node).to be_published
    end
  end

end
