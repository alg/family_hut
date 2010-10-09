# Ownership check. Subject needs .owns?(object) method.
RSpec::Matchers.define :own do |object|
  match do |subject|
    subject.owns?(object)
  end
end
