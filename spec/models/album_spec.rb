require 'spec_helper'

describe Album do

  it { should belong_to :owner }
  it { should belong_to :cover_photo }
  it { should have_many :photos }

  it { should validate_presence_of :name }

  context ".thumbnail_url" do
    let(:album) { Album.new }
    let(:album_with_image) { Factory(:album_with_image) }

    it "should return default album image if not set" do
      album.thumbnail_url.should == Album::DEFAULT_IMAGE_URL
    end
    
    it "should return image thumbnail URL if set" do
      album_with_image.thumbnail_url.should_not == Album::DEFAULT_IMAGE_URL
    end
  end
  
end
