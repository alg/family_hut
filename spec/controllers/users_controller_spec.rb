require 'spec_helper'

describe UsersController do

  let(:user) { Factory(:user) }
  before { login(user) }

  context ".dashboard" do
    before  { get :dashboard }
    specify { response.should render_template(:dashboard) }
    specify { assigns(:albums).should == user.albums }
    specify { assigns(:events).should be }
    specify { assigns(:photos).should be }
  end

  context ".index" do
    before  { get :index }
    specify { response.should render_template(:index) }
    specify { assigns(:users).should == User.all }
  end

  context ".show" do
    before  { get :show }
    specify { response.should render_template(:show) }
  end

  context ".update" do
    it "should succeed with valid data" do
      user.should_receive(:update_attributes).and_return(true)
      post :update
      response.should redirect_to(account_url)
    end

    it "should fail with invalid data" do
      user.should_receive(:update_attributes).and_return(false)
      post :update
      response.should render_template(:edit)
    end
  end

  context ".destroy" do
    before  { delete :destroy }
    specify { response.should redirect_to(login_url) }
    specify { flash[:notice].should == "Your account has been cancelled" }
  end
end
