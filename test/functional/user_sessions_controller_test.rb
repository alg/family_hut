require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  context "logging in" do
    setup do
      user = Factory(:user, :login => "tester", :password => "testing", :password_confirmation => "testing")
      post :create, :user_session => { :login => user.login, :password => user.password }
    end

    should_redirect_to("dashboard") { dashboard_url }
  end
  
  context "logging out" do
    setup do
      log_in_as(Factory(:user))
      post :destroy
    end
    
    should_redirect_to("new_user_session") { new_user_session_url }
  end

end
