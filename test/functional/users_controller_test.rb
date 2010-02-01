require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = log_in
  end

  context "checking the dashboard" do
    setup { get :index }
    should_render_template :index
    should_assign_to(:albums) { @user.albums }
  end
  
  context "checking my account info" do
    setup { get :show }
    should_render_template :show
  end

  context "updating my profile" do
    context "with valid info" do
      setup { post :update, :user => { :name => "some_new_name" } }
      should_redirect_to("account") { account_url }
      should "change name to" do
        assert_equal "some_new_name", @user.reload.name
      end
    end
    
    context "with invalid info" do
      setup { post :update, :user => { :name => "" } }
      should_render_template :edit
    end
  end

  context "cancelling my account" do
    setup { delete :destroy }
    should_redirect_to("login") { login_url }
    should_set_the_flash_to "Your account has been cancelled"
  end
end
