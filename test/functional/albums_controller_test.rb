require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase

  context "security" do
    context "redirect if not logged in" do
      setup { get :index }
      should_redirect_to("login") { login_url }
    end
    
    [ [ "delete", "delete", :destroy ],
      [ "update", "post",   :update ] ].each do |verb, http_verb, action|
      context "#{verb} someone's albums" do
        setup do
          @album = Factory(:album)
          log_in

          send(http_verb, action, :id => @album.id)
        end
        should_set_the_flash_to "You cannot modify someone else's albums"
        should_redirect_to("album") { album_url(@album) }
      end
    end
  end

  context "listing albums" do
    setup { @user = log_in }
    
    context "with many available" do
      setup do
        @user1 = Factory(:user)
        @album1_1 = Factory(:album, :owner => @user1)
        @album2_1 = Factory(:album, :owner => @user1)

        @user2 = Factory(:user)
        @album1_2 = Factory(:album, :owner => @user2)
        @album2_2 = Factory(:album, :owner => @user2)
        
        get :index
      end
      
      should_render_template :index
      should_assign_to(:owners_to_albums) { { @user1 => [ @album1_1, @album2_1 ], @user2 => [ @album1_2, @album2_2 ] } }
    end
  end
  
  context "new albums" do
    setup { @user = log_in }
    
    context "showing new album form" do
      setup { get :new }
      should_render_template :new
      should_assign_to(:album)
    end
    
    context "creating" do
      setup { post :create, :album => { :name => "test" }}
      should_redirect_to("album") { Album.first }
      should "add db record" do
        assert_not_nil Album.find_by_name("test")
      end
    end
    
    context "failing to create" do
      setup { post :create, :album => {} }
      should_render_template :new
    end
  end
  
  context "showing" do
    setup { @user = log_in }
    
    context "showing existing album" do
      setup do
        @album = Factory(:album)
        get :show, :id => @album.id
      end
      should_render_template :show
      should_assign_to(:album) { @album }
    end
    
    context "showing missing album" do
      setup do
        get :show, :id => 0
      end
      should_redirect_to("albums") { albums_url }
    end
  end
end
