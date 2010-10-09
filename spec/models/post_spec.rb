require 'spec_helper'

describe Post do
  
  it { should belong_to :user }
  
  context "when checking if the post can be removed" do
    let(:post) { Factory(:post) }
    let(:post_owner) { post.user }
    let(:other_user) { Factory(:user) }
    
    it "should disallow if the post doesn't belong to a user" do
      post.should_not be_removable_by other_user
    end
    
    it "should disallow if it's too late" do
      create_post
      after_period_for_removing_ended do
        post.should_not be_removable_by post_owner
      end
    end
    
    it "should allow removing posts if within time frame and owned" do
      create_post
      before_period_for_removing_ended do
        post.should be_removable_by post_owner
      end
    end
  end
  
end
