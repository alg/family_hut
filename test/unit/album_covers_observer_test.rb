require 'test_helper'

class AlbumCoversObserverTest < ActiveSupport::TestCase
  
  def setup
    @album = Factory(:album)
  end
  
  should "assign a cover image when uploading the first picture" do
    photo = Factory(:photo_with_image, :album => @album)
    assert_equal photo, @album.cover_photo
  end
  
  should "not assign a new cover image when the one is already present" do
    photo1 = Factory(:photo_with_image, :album => @album)
    photo2 = Factory(:photo_with_image, :album => @album)
    assert_equal photo1, @album.cover_photo
  end
  
  should "find another cover image when the cover photo is removed" do
    photo1 = Factory(:photo_with_image, :album => @album)
    photo2 = Factory(:photo_with_image, :album => @album)

    photo1.destroy
    assert_equal photo2, @album.cover_photo
  end
  
  should "reset cover image when the last photo is removed" do
    photo = Factory(:photo_with_image, :album => @album)
    photo.destroy
    
    assert_nil @album.cover_photo_id
  end
  
end
