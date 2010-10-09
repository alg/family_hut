# Before and after the period for removing ended scopes

def before_period_for_removing_ended(&block)
  Timecop.travel(Post::MAX_DELETABLE_PERIOD.minutes - 1, &block)
end

def after_period_for_removing_ended(&block)
  Timecop.travel(Post::MAX_DELETABLE_PERIOD.minutes + 1, &block)
end

# Lets you address "let(:post) {}" as "create_post" or "created_post"
# in addition to just "post"
def method_missing(name, *args)
  if /^created?_(.+)$/ =~ name.to_s
    send $1
  else
    super
  end
end

# Returns raw fixture data
def fixture_data(filename)
  open("#{Rails.root}/spec/fixtures/#{filename}").read
end

def fixture_file(filename)
  File.open("#{Rails.root}/spec/fixtures/#{filename}", 'rb')
end

# Logs the user in
def login(user = Factory(:user))
  @controller.stub(:current_user).and_return(user)
  Time.zone = user.time_zone
  return user
end
