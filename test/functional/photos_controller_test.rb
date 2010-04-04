require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  context "showing" do
    setup { log_in }
    context "missing photos" do
      setup do
        @album = Factory(:album)
        get :show, :album_id => @album.id, :id => 0
      end
      should_redirect_to("album") { album_url(@album) }
    end
    
    [ [ "delete",       "delete", :destroy ],
      [ "update",       "post",   :update ],
      [ "upload",       "get",    :new ],
      [ "upload ten",   "get",    :new_ten ],
      [ "create",       "put",    :create ],
      [ "create ten",   "put",    :create_ten ] ].each do |verb, http_verb, action|
      context "#{verb} someone's photos" do
        setup do
          @photo = Factory(:photo)
          @album = @photo.album
          log_in
  
          send(http_verb, action, :album_id => @album.id, :id => @photo.id)
        end
        should_set_the_flash_to "You cannot modify someone else's photos"
        should_redirect_to("photo") { album_photo_url(@album, @photo) }
      end
    end
  end
  
  context "AJAX uploads of photos" do
    setup do
      @album = Factory(:album)
      @user  = @album.owner
      log_in_as(@user)

      put :create,  :album_id       => @album.id,
                    :photo          => { :image => fixture_file('images/50x50.gif') },
                    :callback       => 'uploaded_image',
                    :placeholder_id => 12,
                    :format         => 'js'
    end

    should "render the JS callback" do
      pid, ph = 12, assigns(:photo)
      assert_equal "uploaded_image(#{pid}, #{ph.id}, 'Untitled', '#{Time.zone.now.to_s(:date_time)}', '#{ph.image.url(:brief)}', '#{album_photo_path(@album.id, ph.id)}');", @response.body.strip
    end
  end
  
  context "updating titles" do
    setup do
      @photo = Factory(:photo)
      @album = @photo.album
      @user  = @album.owner
      log_in_as(@user)
      
      post :update_title, :album_id => @album.id, :id => @photo.id, :title => "New title"
    end
    should "update photo title" do
      @photo.reload
      assert_equal "New title", @photo.title
    end
  end
  
  context "creating comments" do
    setup do
      @photo = Factory(:photo)
      @album = @photo.album
      @user  = @album.owner
      log_in_as(@user)
    end
    
    context "successful" do
      setup { post :create_comment, :album_id => @album.id, :id => @photo.id, :comment => { :comment => "Hello" } }
      should_redirect_to("album_photo") { album_photo_url(@album, @photo, :anchor => "comments") }
      should "add comment to db" do
        c = @photo.comments.first
        assert_equal "Hello", c.comment
        assert_equal @user, c.user
      end
    end
    
    context "failed" do
      setup { post :create_comment, :album_id => @album.id, :id => @photo.id }
      should_render_template :show
    end
    
    context "missing photo" do
      setup { post :create_comment, :album_id => @album.id, :id => 999, :comment => { :comment => "Hello" } }
      should_redirect_to("album") { album_url(@album) }
    end
  end

end
