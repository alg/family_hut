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
    Time.zone = user.time_zone
  end
end

# Returns raw fixture data
def fixture_data(filename)
  open(RAILS_ROOT + "/test/fixtures/#{filename}").read
end

def fixture_file(filename)
  File.open(RAILS_ROOT + "/test/fixtures/#{filename}", 'rb')
end