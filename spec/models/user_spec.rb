require 'spec_helper'

describe User do

  it { should validate_presence_of   :name }
  it { should validate_presence_of   :login }
  it { should validate_presence_of   :email }

  it { should have_many :albums }
  it { should have_many :comments }
  it { should have_many :logs }
  it { should have_many :posts }

  context "with some other users" do
    before { Factory(:user) }
    it { should validate_uniqueness_of :login }
    it { should validate_uniqueness_of :email }
  end

  context "when checking ownership" do
    let(:user) { Factory(:user) }
    let(:his_album) { Factory(:album, :owner => user) }
    let(:his_photo) { Factory(:photo, :album => his_album) }
    let(:someones_album) { Factory(:album) }
    let(:someones_photo) { Factory(:photo) }

    subject { user }
    
    it { should     own his_album }
    it { should     own his_photo }
    it { should_not own someones_album }
    it { should_not own someones_photo }
    it { should_not own nil }
  end
end