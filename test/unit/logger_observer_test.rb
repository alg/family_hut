require 'test_helper'

class LoggingObserverTest < ActiveSupport::TestCase

  def setup
    Log.delete_all
  end
  
  should "log creating an album" do
    @album = Factory(:album)
    assert_log(@album.owner, "Created album", album_path(@album))
  end

  should "log creating a photo" do
    @photo = Factory(:photo)
    assert_log(@photo.album.owner, "Uploaded photos to album", album_path(@photo.album))
  end

  should "log once for multiple uploaded photos to the same album" do
    photo = Factory(:photo)
    Factory(:photo, :album => photo.album)
    assert_equal 1, Log.count(:conditions => { :activity => "Uploaded photos to album" })
  end
  
  should "log creating a comment" do
    photo = Factory(:photo)
    Factory(:comment, :commentable => photo, :comment => "Something that I said")
    
    album = photo.album
    user  = album.owner
    comment = photo.comments.last
    assert_log(user, "Commented on photo", "<a href='/albums/#{album.to_param}/photos/#{photo.to_param}'>#{photo.title}</a> from album #{album_path(album)}:<div class='body'>#{comment.comment}</div>")
  end

  private
  
  def album_path(album)
    "<a href='/albums/#{album.to_param}'>#{album.name}</a>"
  end
  
  def assert_log(user, activity, target)
    l = Log.last
    assert_equal user, l.user
    assert_equal activity, l.activity
    assert_equal target, l.target
  end
end
