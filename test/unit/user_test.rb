require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_validate_presence_of :name, :login, :email
  
  should_have_many :albums, :dependent => :destroy
  should_have_many :comments, :dependent => :destroy
  should_have_many :logs, :dependent => :destroy

end
