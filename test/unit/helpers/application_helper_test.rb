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

end
