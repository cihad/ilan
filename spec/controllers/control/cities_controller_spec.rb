require 'spec_helper'

describe Control::CitiesController do

  let(:valid_attributes) { FactoryGirl.attributes_for :city }
  let(:invalid_attributes) { valid_attributes.merge(name: "") }
  let(:valid_session) { {} }
  let!(:city) { create :city }

  describe "GET index" do
    it "assigns all cities as @cities" do
      city =  double
      City.stub(:all).and_return([city])
      get :index, {}, valid_session
      assigns(:cities).should eq([city])
    end
  end

  describe "GET new" do
    it "assigns a new city as @city" do
      city = double
      City.stub(:new).and_return(city)
      get :new, {}, valid_session
      assigns(:city).should eq(city)
    end
  end

  describe "GET edit" do
    it "assigns the requested city as @city" do
      get :edit, {:id => city.to_param}, valid_session
      assigns(:city).should eq(city)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new City" do
        expect {
          post :create, {:city => valid_attributes}, valid_session
        }.to change(City, :count).by(1)
      end

      it "assigns a newly created city as @city" do
        post :create, {:city => valid_attributes}, valid_session
        assigns(:city).should be_a(City)
        assigns(:city).should be_persisted
      end

      it "redirects to the created city" do
        City.any_instance.stub(:save).and_return(true)
        city = stub_model(City, id: 1000)
        City.stub(:new).and_return(city)
        controller.stub(:city_params)
        post :create
        response.should redirect_to(control_cities_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved city as @city" do
        # Trigger the behavior that occurs when invalid params are submitted
        City.any_instance.stub(:save).and_return(false)
        post :create, {:city => invalid_attributes}, valid_session
        assigns(:city).should be_a_new(City)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        City.any_instance.stub(:save).and_return(false)
        post :create, {:city => invalid_attributes}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested city" do
        attrs = valid_attributes
        put :update, {:id => city.to_param, :city => attrs}, valid_session
        city.reload.name.should eq(attrs[:name])
      end

      it "assigns the requested city as @city" do
        put :update, {:id => city.to_param, :city => valid_attributes}, valid_session
        assigns(:city).should eq(city)
      end

      it "redirects to the city" do
        City.any_instance.stub(:update).and_return(true)
        controller.stub(:city_params)
        put :update, {:id => city.to_param }, valid_session
        response.should redirect_to(control_cities_path)
      end
    end

    describe "with invalid params" do
      it "assigns the city as @city" do
        put :update, {:id => city.to_param, :city => invalid_attributes}, valid_session
        assigns(:city).should eq(city)
      end

      it "re-renders the 'edit' template" do
        City.any_instance.stub(:update).and_return(false)
        controller.stub(:city_params)
        put :update, {:id => city.to_param }, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested city" do
      expect {
        delete :destroy, {:id => city.to_param}, valid_session
      }.to change(City, :count).by(-1)
    end

    it "redirects to the cities list" do
      delete :destroy, {:id => city.to_param}, valid_session
      response.should redirect_to(control_cities_url)
    end
  end

end
