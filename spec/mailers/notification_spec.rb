require 'spec_helper'

describe Notification do
  
  describe 'new_photos' do
    let(:photo) { Factory(:photo) }
    let(:user)  { Factory(:user) }
    
    subject { Notification.new_photos([ user ], [ photo ]) }
    
    its(:subject) { should == "New Photos" }
    its(:to)      { should == [ user.email ] }
    its(:from)    { should == [ AppConfig['from'] ] }
    its(:body)    { should match photo.image.url(:brief) }
    its(:body)    { should match 'Recent uploads' }
    its(:body)    { should match "#{photo.album.owner.name} has uploaded:" }
  end
  
end