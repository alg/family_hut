ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'shoulda'
require "authlogic/test_case"

class ActiveSupport::TestCase
  def log_in
    user = Factory(:user)
    log_in_as(user)
    return user
  end
  
  def log_in_as(user)
    activate_authlogic
    UserSession.create(user)
  end
end
