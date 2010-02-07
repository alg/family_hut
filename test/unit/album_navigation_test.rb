require 'test_helper'

class AlbumNavigationTest < ActiveSupport::TestCase
  
  def setup
    @album  = Factory(:album)
    @photos = (0 ... 3).inject([]) { |memo, _| memo << Factory(:photo, :album => @album) }
  end

  context "getting ids" do
    should "return correct ID's of previous photos" do
      assert @photos[1], @album.previous_photo_id(@photos[0])
      assert @photos[2], @album.previous_photo_id(@photos[1])
      assert_nil @album.previous_photo_id(@photos[2])
    end
  
    should "return correct ID's of next photos" do
      assert @photos[1], @album.next_photo_id(@photos[2])
      assert @photos[0], @album.next_photo_id(@photos[1])
      assert_nil @album.next_photo_id(@photos[0])
    end
  end
end