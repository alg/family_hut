require 'spec_helper'

describe ApplicationHelper do

  let(:album) { Factory(:album) }
  let(:owner) { album.owner }

  context ".owns?" do
    specify { helper.owns?(album, nil).should_not be_true }

    it "should invoke the check on subject" do
      owner.should_receive(:owns?).with(album)
      helper.owns?(album, owner)
    end
  end
  
end
