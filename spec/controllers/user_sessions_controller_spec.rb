require 'spec_helper'

describe UserSessionsController do

  let(:user) { Factory(:user, :login => "tester", :password => "testing", :password_confirmation => "testing") }
  
  it "should login successfully" do
    @controller.stub(:require_no_user)
    UserSession.should_receive(:new).and_return(stub(:save => true))
    post :create
    response.should redirect_to(dashboard_url)
  end

  it "should fail the login" do
    @controller.stub(:require_no_user)
    UserSession.should_receive(:new).and_return(stub(:save => false))
    post :create
    response.should render_template(:new)
  end
  
  it "should log out" do
    @controller.should_receive(:current_user_session).and_return(mock(:destroy => true))
    login user
    post :destroy
    response.should redirect_to(new_user_session_url)
  end

end
