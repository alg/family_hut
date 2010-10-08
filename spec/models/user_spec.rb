require 'spec_helper'

describe User do

  it { should validate_presence_of   :name }
  it { should validate_presence_of   :login }
  it { should validate_presence_of   :email }

  it { should have_many :albums }
  it { should have_many :comments }
  it { should have_many :logs }
  it { should have_many :posts }

  context "with some users" do
    before { Factory(:user) }
    it { should validate_uniqueness_of :login }
    it { should validate_uniqueness_of :email }
  end

end