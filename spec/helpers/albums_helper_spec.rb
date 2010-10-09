require 'spec_helper'

describe AlbumsHelper do

  let(:album) { Factory(:album) }
  let(:photo) { Factory(:photo, :album => album) }
  let(:another_photo) { Factory(:photo, :album => album) }
  
  before do
    create_photo
    create_another_photo
  end

  specify { link_to_previous_photo(another_photo).should be_nil }
  specify { link_to_previous_photo(photo).should == "<div class=\"prev\"><a href=\"/albums/#{album.id}/photos/#{another_photo.id}\">&lt;&lt;</a></div>" }
  specify { link_to_next_photo(photo).should be_nil }
  specify { link_to_next_photo(another_photo).should == "<div class=\"next\"><a href=\"/albums/#{album.id}/photos/#{photo.id}\">&gt;&gt;</a></div>" }

end
