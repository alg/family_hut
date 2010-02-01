require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  context "album image url" do 
    should "return default album image url for empty album" do
      assert_equal "/images/empty_album.jpg", album_image_url(Album.new)
    end
    
    should "return the url of the first image in the album" do
      photo = Factory(:photo)
      assert_equal "/images/thumb/missing.png", album_image_url(photo.album)
    end
  end

  context "owns" do
    should "return either TRUE or FALSE when owning and not owning an album" do
      album = Factory(:album)
      user1 = album.owner
      user2 = Factory(:user)

      assert owns?(album, user1)
      assert !owns?(album, user2)
    end
    
    should "return either TRUE or FALSE when owning a photo" do
      photo = Factory(:photo)
      user1 = photo.album.owner
      user2 = Factory(:user)
      
      assert owns?(photo, user1)
      assert !owns?(photo, user2)
    end
  end
end
