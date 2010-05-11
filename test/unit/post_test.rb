require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def test_can_be_deleted
    p = Factory(:post)
    assert p.can_be_deleted?(p.user)
    assert !p.can_be_deleted?(Factory(:user))
    
    p.stubs(:created_at).returns((Post::MAX_DELETABLE_PERIOD + 1).minutes.ago)
    assert !p.can_be_deleted?(p.user)
  end

end
