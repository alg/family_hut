require 'spec_helper'

describe PhotosController do

  let(:album) { Factory(:album) }
  let(:photo) { Factory(:photo, :album => album) }
  
  context ".show" do
    before { login }
    
    context "missing image" do
      before  { get :show, :album_id => album.id, :id => -1 }
      specify { response.should redirect_to(album_url(album)) }
    end

    [ [ "delete",       "delete", :destroy ],
      [ "update",       "post",   :update ],
      [ "upload",       "get",    :new ],
      [ "upload ten",   "get",    :new_ten ],
      [ "create",       "put",    :create ],
      [ "create ten",   "put",    :create_ten ] ].each do |verb, http_verb, action|
      context "#{verb} someone's photos" do
        before  { send(http_verb, action, :album_id => album.id, :id => photo.id) }
        specify { flash[:error].should == "You cannot modify someone else's photos" }
        specify { response.should redirect_to(album_photo_url(album, photo)) }
      end
    end
  end
  
  context "AJAX .create" do
    before do
      login album.owner

      get :create,  :album_id       => album.id,
                    :photo          => { :image => fixture_file('images/1x1.gif') },
                    :callback       => 'uploaded_image',
                    :placeholder_id => 12,
                    :format         => 'js'
    end

    specify { response.should render_template(:create) }
  end
  
  context ".update_title" do
    before do
      login album.owner
      post :update_title, :album_id => album.id, :id => photo.id, :title => "New title"
    end

    specify { photo.reload.title.should == "New title" }
  end
  
  context ".create_comment" do
    before { login album.owner }
    
    context "successful" do
      before  { post :create_comment, :album_id => album.id, :id => photo.id, :comment => { :comment => "Hello" } }
      specify { response.should redirect_to(album_photo_url(album, photo, :anchor => "comments")) }
      specify { photo.comments.size.should_not == 0 }
    end
    
    context "failed" do
      before  { post :create_comment, :album_id => album.id, :id => photo.id }
      specify { response.should render_template(:show) }
    end
    
    context "missing photo" do
      before  { post :create_comment, :album_id => album.id, :id => 999, :comment => { :comment => "Hello" } }
      specify { response.should redirect_to(album_url(album)) }
    end
  end

end
