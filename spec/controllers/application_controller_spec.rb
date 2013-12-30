require 'spec_helper'

describe ApplicationController do
  describe "#current_city" do
    it "when current_city_id session exists" do
      id = double
      city = double
      request.session[:current_city_id] = id
      City.stub(:find_by).with(id: id).and_return(city)

      expect(controller.send(:current_city)).to eq(city)
    end

    it "when current_city_id session is nil" do
      request.session[:current_city_id] = nil

      city = double
      DefaultCityPolicy.stub(:default_city).and_return(city)

      expect(controller.send(:current_city)).to eq(city)
    end

    it "is a helper method" do
      expect(controller._helper_methods).to be_include(:current_city)
    end
  end

  it "#current_city=" do
    id = "123"
    city = double
    City.stub(:find_by).with(id: id).and_return(city)
    controller.send(:"current_city=", id)

    expect(controller.session[:current_city_id]).to eq(id)
    expect(controller.send(:current_city)).to eq(city)
  end

end
