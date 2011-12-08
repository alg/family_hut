require 'spec_helper'

describe ActivityObserver do

  let(:album) { Factory(:album) }
  let(:photo) { Factory(:photo, :album => album) }
  let(:another_photo) { Factory(:photo, :album => album) }
  let(:user) { Factory(:user) }
  let(:comment) { Factory(:comment, :user => user, :commentable => photo)}

  before { Log.delete_all }

  it "should log creating an album" do
    create_album
    album.owner.should log('activity.album.created', {
      :album_id     => album.id,
      :album_name   => album.name })
  end

  it "should log creating a photo" do
    create_photo
    album.owner.should log('activity.photo.created', {
      :album_id     => album.id,
      :album_name   => album.name,
      :photo_id     => photo.id,
      :photo_title  => photo.title })
  end

  it "should log once for multiple uploaded photos to the same album" do
    create_photo
    create_another_photo
    Log.where(:activity => 'activity.photo.created').count.should == 1
  end

  it "should log creating a comment" do
    create_comment
    user.should log('activity.comment.created', {
      :album_id   => album.id,   :album_name      => album.name,
      :photo_id   => photo.id,   :photo_title     => photo.title,
      :comment_id => comment.id, :comment_comment => comment.comment })
  end

end
