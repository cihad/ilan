require 'spec_helper'

describe CategoriesController do
  
  let(:valid_session) { {} }

  it "GET /categories/:id" do
    category = double to_param: "123"
    Category.stub(:find).with("123").and_return(category)

    nodes = double
    category.stub_chain(:nodes, :with_published_state, :where, :order, :page, :per).and_return(nodes)
    get :show, {:id => category.to_param}, valid_session

    expect(assigns(:category)).to eq(category)
    expect(assigns(:nodes)).to eq(nodes)
  end

end