require 'test_helper'

class AlbumsHelperTest < ActionView::TestCase

  def setup
    @album  = Factory(:album)
    @photo1 = Factory(:photo, :album => @album)
    @photo2 = Factory(:photo, :album => @album)
  end
  
  should "return the tag for the previous photo" do
    # Everything is reversed -- latest first
    assert_nil link_to_previous_photo(@photo2)
    assert_equal "<div class=\"prev\"><a href=\"/albums/#{@album.id}/photos/#{@photo2.id}\">&lt;&lt; Previous</a></div>", link_to_previous_photo(@photo1)
  end
  
  should "return the tag for the next photo" do
    # Everything is reversed -- latest first
    assert_nil link_to_next_photo(@photo1)
    assert_equal "<div class=\"next\"><a href=\"/albums/#{@album.id}/photos/#{@photo1.id}\">Next &gt;&gt;</a></div>", link_to_next_photo(@photo2)
  end

end
