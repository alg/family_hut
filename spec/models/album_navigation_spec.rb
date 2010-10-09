require 'spec_helper'

describe AlbumNavigation do

  let(:album) { Factory(:album) }
  let(:photos) { (0 ... 3).inject([]) { |memo, _| memo << Factory(:photo, :album => album) } }

  context "when getting ids" do
    it "should return correct ID's of previous photos" do
      [ photos[1].id, photos[2].id, nil ].each_with_index do |p, i|
        album.previous_photo_id(photos[i]).should == p
      end
    end

    it "should return correct ID's of next photos" do
      [ nil, photos[0].id, photos[1].id ].each_with_index do |p, i|
        album.next_photo_id(photos[i]).should == p
      end
    end
  end

end
