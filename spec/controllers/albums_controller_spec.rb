require 'spec_helper'

describe AlbumsController do
  
  context "security" do
    let(:user) { Factory(:user) }
    let(:someones_album) { Factory(:album) }

    it "should redirect if not logged in" do
      get :index
      response.should redirect_to(login_url)
    end
    
    [ [ "delete", "delete", :destroy ],
      [ "update", "post",   :update ] ].each do |verb, http_verb, action|
      it "should disallow #{verb} someone's albums" do
        login(user)
        send(http_verb, action, :id => someones_album.id)
        flash[:error].should == "You cannot modify someone else's albums"
        response.should redirect_to(album_url(someones_album))
      end
    end
  end

  context ".index" do
    let(:first_user) { Factory(:user) }
    let(:second_user) { Factory(:user) }
    
    it "should return the list of all albums groupped by owners" do
      login

      a1 = Factory(:album, :owner => first_user)
      a2 = Factory(:album, :owner => first_user)
      a3 = Factory(:album, :owner => second_user)
      a4 = Factory(:album, :owner => second_user)
      
      get :index
      
      response.should render_template(:index)
      assigns(:owners_to_albums).should == { first_user => [ a1, a2 ], second_user => [ a3, a4 ] }
    end
  end

  context ".new" do
    it "should render the form" do
      login
      get :new
      response.should render_template(:new)
      assigns(:album).should_not be_nil
    end
  end
  
  context ".create" do
    it "should set current user and delegate to IR create!" do
      user = login
      post :create, :album => Factory.attributes_for(:album)
      assigns(:album).owner.should == user
      response.should redirect_to(album_url(assigns(:album)))
    end
  end
  
  context ".show" do
    it "should delegate showing to IR show!" do
      login
      @controller.should_receive(:show!)
      post :show, :id => 0
    end
    
    it "should redirect to the albums list when album is not found" do
      login
      @controller.stub(:show!).and_raise(ActiveRecord::RecordNotFound)
      post :show, :id => 0
      response.should redirect_to(albums_url)
    end
  end
end
