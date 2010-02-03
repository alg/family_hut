require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  should_belong_to :album

  should "normalize title to be Untitled when no title is given" do
    photo = Factory(:photo, :title => "")
    assert_equal "Untitled", photo.title
  end
  
  should "return photos with images" do
    photo = Factory(:photo)
    photo_with_image = Factory(:photo_with_image)
    
    assert_equal [ photo_with_image ], Photo.with_image.all
  end
end
