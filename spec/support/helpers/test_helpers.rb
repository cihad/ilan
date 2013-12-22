module TestHelpers

  def login_as_admin
    ActionController::HttpAuthentication::Basic.stub(:authenticate).and_return(true)
  end

end