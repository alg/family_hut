Factory.sequence(:name) { |n| "name_#{n}" }
Factory.sequence(:login) { |n| "login_#{n}" }
Factory.sequence(:email) { |n| "email_#{n}@email.com" }

Factory.define :user do |f|
  f.name                  { Factory.next(:name) }
  f.login                 { Factory.next(:login) }
  f.email                 { Factory.next(:email) }
  f.password              'testing'
  f.password_confirmation { |o| o.password }
end

Factory.define :album do |f|
  f.name                  { Factory.next(:name) }
  f.association           :owner, :factory => :user
end

Factory.define :photo do |f|
  f.title                 { Factory.next(:name) }
  f.association           :album
end