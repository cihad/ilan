require 'spec_helper'

describe HomePageController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "assigns node_list" do
      grouped_nodes = double
      Node.stub(:group_by_category).and_return(grouped_nodes)

      catalog = double
      catalog_instance = double(catalog: catalog)
      Catalog.stub(:new).with(grouped_nodes).and_return(catalog_instance)

      get :index
      expect(assigns(:catalog)).to eq(catalog)
    end
  end

end
