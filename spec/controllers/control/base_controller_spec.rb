require 'spec_helper'

describe Control::BaseController do
  describe "GET /index" do
    context "when login" do
      it "not returns http success" do
        login_as_admin
        get 'index'
        response.should be_success
      end
    end

    context "when not login" do
      it "returns http success" do
        get 'index'
        response.should_not be_success
      end
    end
  end
end
