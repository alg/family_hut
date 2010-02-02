require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  should_belong_to :album

  should "normalize title to be Untitled when no title is given" do
    photo = Factory(:photo, :title => "")
    assert_equal "Untitled", photo.title
  end
  
end
