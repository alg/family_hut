require 'test_helper'

class AlbumTest < ActiveSupport::TestCase

  should_belong_to :owner
  should_have_many :photos, :dependent => :delete_all
  should_belong_to :cover_photo
  
  should_validate_presence_of :name

  context "thumbnail url" do
    should "return nil if there are no images in the album yet" do
      assert_equal "/images/empty_album.png", Album.new.thumbnail_url
    end

    should "return the first photo thumbnail as the result" do
      photo = Factory(:photo_with_image)
      photo.album.cover_photo_id = photo.id
      assert_equal "/assets/photos/#{photo.id}/thumb.jpg", photo.album.thumbnail_url
    end
  end
end
