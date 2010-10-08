Factory.sequence(:name) { |n| "name_#{n}" }
Factory.sequence(:login) { |n| "login_#{n}" }
Factory.sequence(:email) { |n| "email_#{n}@email.com" }

Factory.define :user do |f|
  f.name                  { Factory.next(:name) }
  f.login                 { Factory.next(:login) }
  f.email                 { Factory.next(:email) }
  f.password              'testing'
  f.password_confirmation { |o| o.password }
  f.locale                'en'
end

Factory.define :album do |f|
  f.name                  { Factory.next(:name) }
  f.association           :owner, :factory => :user
end

Factory.define :album_with_image, :parent => :album do |f|
  f.association           :cover_photo, :factory => :photo
end

Factory.define :photo do |f|
  f.title                 { Factory.next(:name) }
  f.association           :album
end

Factory.define :photo_with_image, :parent => :photo do |f|
  f.image_file_name       { Factory.next(:name) }
  f.image_content_type    "image/jpg"
  f.image_file_size       1000
  f.image_updated_at      Time.now
end

Factory.define :comment do |f|
  f.comment               "test"
  f.comment_type          "comment"
end

Factory.define :post do |f|
  f.association           :user
  f.body                  'test'
end