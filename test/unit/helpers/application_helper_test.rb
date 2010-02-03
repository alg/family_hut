require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
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
