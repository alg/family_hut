require 'test_helper'

class NavigatorTest < ActiveSupport::TestCase
  
  def setup
    @album  = Factory(:album)
    @photos = (0 ... 3).inject([]) { |memo, _| memo << Factory(:photo, :album => @album) }
  end

  context "after" do
    [ false, true, true ].each_with_index do |state, i|
      should "have photo after #{i}" do
        assert_equal state, Navigator.has_photo_after?(@photos[i])
      end
    end
    
    should "return false for nil" do
      assert !Navigator.has_photo_after?(nil)
    end
  end

  context "before" do
    [ true, true, false ].each_with_index do |state, i|
      should "have photo before #{i}" do
        assert_equal state, Navigator.has_photo_before?(@photos[i])
      end
    end
    
    should "return false for nil" do
      assert !Navigator.has_photo_before?(nil)
    end
  end

  context "getting ids" do
    should "return correct ID's of previous photos" do
      assert @photos[1], Navigator.photo_id_before(@photos[0])
      assert @photos[2], Navigator.photo_id_before(@photos[1])
      assert_nil Navigator.photo_id_before(@photos[2])
    end

    should "return correct ID's of next photos" do
      assert @photos[1], Navigator.photo_id_after(@photos[2])
      assert @photos[0], Navigator.photo_id_after(@photos[1])
      assert_nil Navigator.photo_id_after(@photos[0])
    end
  end
end