require 'spec_helper'

describe Notification do
  
  describe 'news' do
    let(:photo)     { Factory(:photo) }
    let(:photo2)    { Factory(:photo) }
    let(:mark)      { Factory(:user, :name => 'Mark') }
    let(:mary)      { Factory(:user, :name => 'Mary') }
    let(:comment1)  { Factory(:comment, :commentable => photo,  :user => mark, :comment => "c1") }
    let(:comment2)  { Factory(:comment, :commentable => photo,  :user => mary, :comment => "c2") }
    let(:comment3)  { Factory(:comment, :commentable => photo2, :user => mark, :comment => "c3") }

    context 'general' do
      subject { Notification.news([ mark ], [ photo ], []) }
      its(:subject) { should == "Family Hut News" }
      its(:to)      { should == [ mark.email ] }
      its(:from)    { should == [ AppConfig['from'] ] }
    end
    
    context 'with uploads only' do
      subject { Notification.news([ mark ], [ photo ], []) }
      its(:body)    { should match photo.image.url(:brief) }
      its(:body)    { should match 'Recent Uploads' }
      its(:body)    { should match "#{photo.album.owner.name} has uploaded:" }
      its(:body)    { should_not match 'Recent Comments' }
    end
    
    context 'with comments only' do
      subject { Notification.news([ mark ], [ ], [ comment1, comment2, comment3 ]) }
      its(:body)    { should match 'Recent Comments' }
      its(:body)    { should match comment1.comment }
      its(:body)    { should match comment1.user.name }
      its(:body)    { should match comment2.comment }
      its(:body)    { should match comment2.user.name }
      its(:body)    { should match comment3.comment }
      its(:body)    { should match comment3.user.name }
    end
    
  end
  
end