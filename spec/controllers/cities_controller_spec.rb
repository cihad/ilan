require 'spec_helper'

describe CitiesController do

  describe "show" do
    let(:city) { double }

    before do
      City.stub(:find_by).with(id: "123").and_return(city)
    end

    it "gets :id parameter" do
      get :show, { id: "123" }
      expect(controller.params[:id]).to eq("123")
    end

    it "sets current city" do
      get :show, { id: "123" }

      expect(controller.send :current_city).to eq(city)
    end

    it "redirects to back when HTTP_REFERER exist" do
      request.env["HTTP_REFERER"] = "/redirect_url"
      get :show, { id: "123" }
      expect(response).to redirect_to("/redirect_url")
    end

    it "redirect to root_path when HTTP_REFERER not exist" do
      get :show, { id: "123" }
      expect(response).to redirect_to(root_path)
    end
  end

end
