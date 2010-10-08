require 'spec_helper'

describe Photo do
  
  it { should belong_to :album }

  it "should normalize title to be Untitled when no title is given" do
    Factory(:photo, :title => "").title.should == "Untitled"
  end

  it "should return photos with images" do
    photo = Factory(:photo)
    photo_with_image = Factory(:photo_with_image)
    Photo.with_image.all.should == [ photo_with_image ]
  end
  
end
