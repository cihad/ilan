require 'spec_helper'

describe NodesController do

  let(:valid_attributes) { FactoryGirl.attributes_for :node }
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested node as @node" do
      node = create :node
      get :show, {:id => node.to_param}, valid_session
      assigns(:node).should eq(node)
    end
  end

  describe "GET new" do
    it "assigns a new node as @node" do
      get :new, {}, valid_session
      assigns(:node).should be_a_new(Node)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Node" do
        expect {
          post :create, {:node => valid_attributes}, valid_session
        }.to change(Node, :count).by(1)
      end

      it "assigns a newly created node as @node" do
        post :create, {:node => valid_attributes}, valid_session
        assigns(:node).should be_a(Node)
        assigns(:node).should be_persisted
      end

      it "redirects to the created node" do
        post :create, {:node => valid_attributes}, valid_session
        response.should redirect_to(Node.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved node as @node" do
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        post :create, {:node => { "title" => "" }}, valid_session
        assigns(:node).should be_a_new(Node)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        post :create, {:node => { "title" => "" }}, valid_session
        response.should render_template("new")
      end
    end
  end

end
