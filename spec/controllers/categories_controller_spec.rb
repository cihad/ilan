require 'spec_helper'

describe CategoriesController do

  let(:valid_attributes) { FactoryGirl.attributes_for :category }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = double
      categories = [category]
      Category.stub(:all).and_return(categories)
      get :index, {}, valid_session
      assigns(:categories).should eq(categories)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}, valid_session
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = stub_model Category
      Category.stub(:find).with(category.to_param).and_return(category)
      get :edit, {:id => category.to_param}, valid_session
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}, valid_session
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}, valid_session
        response.should redirect_to(categories_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => { "name" => "" }}, valid_session
        assigns(:category).should be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => { "name" => "" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = create :category
        Category.any_instance.should_receive(:update).with({ "name" => "Sample" })
        put :update, {:id => category.to_param, :category => { "name" => "Sample" }}, valid_session
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        response.should redirect_to(categories_path)
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = create :category
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { "name" => "invalid value" }}, valid_session
        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        category = create :category
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { "name" => "whatever" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = create :category
      expect {
        delete :destroy, {:id => category.to_param}, valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = create :category
      delete :destroy, {:id => category.to_param}, valid_session
      response.should redirect_to(categories_url)
    end
  end

end
