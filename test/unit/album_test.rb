require 'test_helper'

class AlbumTest < ActiveSupport::TestCase

  should_belong_to :owner
  should_have_many :photos, :dependent => :delete_all
  
  should_validate_presence_of :name

  context "thumbnail url" do
    should "return nil if there are no images in the album yet" do
      assert_nil Album.new.thumbnail_url
    end

    should "return the first photo thumbnail as the result" do
      photo = Factory(:photo)
      assert_equal "/images/thumb/missing.png", photo.album.thumbnail_url
    end
  end
end
