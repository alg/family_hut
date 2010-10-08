ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
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