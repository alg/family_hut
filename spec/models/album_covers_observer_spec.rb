require 'spec_helper'

describe AlbumCoversObserver do
  
  let(:album) { Factory(:album) }
  let(:photo) { Factory(:photo_with_image, :album => album) }
  let(:another_photo) { Factory(:photo_with_image, :album => album) }

  before { create_photo }
  
  it "should assign a cover image when uploading the first picture" do
    album.cover_photo.should == photo
  end
  
  it "should not assign a new cover image when the one is already present" do
    create_another_photo
    album.cover_photo.should == photo
  end
  
  it "should find another cover image when the cover photo is removed" do
    create_another_photo
    photo.destroy
    album.cover_photo.should == another_photo
  end
  
  it "should reset cover image when the last photo is removed" do
    photo.destroy
    album.cover_photo_id.should be_nil
  end
  
end
