# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100429221125) do

  create_table "albums", :force => true do |t|
    t.string   "name",                          :null => false
    t.integer  "user_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photos_count",   :default => 0, :null => false
    t.integer  "cover_photo_id"
  end

  add_index "albums", ["user_id"], :name => "index_albums_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.string   "comment_type"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["comment_type"], :name => "index_comments_on_comment_type"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "logs", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "activity",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  add_index "logs", ["created_at"], :name => "index_logs_on_created_at"

  create_table "photos", :force => true do |t|
    t.integer  "album_id",           :null => false
    t.string   "title"
    t.text     "desc"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], :name => "index_photos_on_album_id"

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                   :null => false
    t.string   "name",                                    :null => false
    t.string   "location"
    t.string   "email",                                   :null => false
    t.string   "crypted_password",                        :null => false
    t.string   "password_salt",                           :null => false
    t.string   "persistence_token",                       :null => false
    t.string   "single_access_token",                     :null => false
    t.string   "perishable_token",                        :null => false
    t.integer  "login_count",         :default => 0,      :null => false
    t.integer  "failed_login_count",  :default => 0,      :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "locale",              :default => "ru"
    t.string   "time_zone",           :default => "Kyev"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
