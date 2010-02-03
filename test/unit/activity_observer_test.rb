require 'test_helper'

class ActivityObserverTest < ActiveSupport::TestCase

  def setup
    Log.delete_all
  end
  
  should "log creating an album" do
    @album = Factory(:album)
    assert_log(@album.owner, "activity.album.created", {
      :album_id => @album.id, :album_name => @album.name })
  end

  should "log creating a photo" do
    photo = Factory(:photo)
    album = photo.album
    assert_log(album.owner, "activity.photo.created", {
      :album_id     => album.id,
      :album_name   => album.name,
      :photo_id     => photo.id,
      :photo_title  => photo.title })
  end

  should "log once for multiple uploaded photos to the same album" do
    photo = Factory(:photo)
    Factory(:photo, :album => photo.album)
    assert_equal 1, Log.count(:conditions => { :activity => "activity.photo.created" })
  end
  
  should "log creating a comment" do
    photo = Factory(:photo)
    Factory(:comment, :commentable => photo, :comment => "Something that I said")
    
    album = photo.album
    user  = album.owner
    comment = photo.comments.last
    assert_log(user, "activity.comment.created", {
      :album_id   => album.id,   :album_name      => album.name,
      :photo_id   => photo.id,   :photo_title     => photo.title,
      :comment_id => comment.id, :comment_comment => comment.comment })
  end

  private
  
  def assert_log(user, activity, data)
    l = Log.last
    assert_not_nil l, "Nothing was logged"
    assert_equal user, l.user
    assert_equal activity, l.activity
    assert_equal data, l.data
  end
end
