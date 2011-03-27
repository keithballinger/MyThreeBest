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

ActiveRecord::Schema.define(:version => 20110327201154) do

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "friend_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "invites", :force => true do |t|
    t.integer  "inviter_id", :null => false
    t.integer  "invited_id", :null => false
    t.string   "status",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["inviter_id"], :name => "index_invites_on_inviter_id"

  create_table "photo_permissions", :force => true do |t|
    t.integer  "photo_id",   :null => false
    t.integer  "owner_id",   :null => false
    t.integer  "friend_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_permissions", ["friend_id"], :name => "index_photo_permissions_on_friend_id"

  create_table "photo_tags", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.text     "title"
    t.string   "url",                                :null => false
    t.string   "preview_url"
    t.integer  "user_id",                            :null => false
    t.integer  "total_votes",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_id"
    t.boolean  "profile_picture", :default => false, :null => false
  end

  add_index "photos", ["facebook_id"], :name => "index_photos_on_facebook_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "user_jobs", :force => true do |t|
    t.string   "job_id",     :null => false
    t.integer  "user_id",    :null => false
    t.string   "job_type",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "user_jobs", ["user_id", "job_type"], :name => "index_user_jobs_on_user_id_and_job_type"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "facebook_uid",                         :null => false
    t.string   "facebook_token"
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_picture"
    t.integer  "top_photo_one_id"
    t.integer  "top_photo_two_id"
    t.integer  "top_photo_three_id"
    t.boolean  "public_page",        :default => true
    t.string   "public_page_url"
    t.string   "email"
  end

  add_index "users", ["facebook_uid"], :name => "index_users_on_facebook_uid", :unique => true
  add_index "users", ["public_page_url"], :name => "index_users_on_public_page_url"

  create_table "votes", :force => true do |t|
    t.integer  "voter_id",   :null => false
    t.integer  "photo_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["photo_id"], :name => "index_votes_on_photo_id"
  add_index "votes", ["voter_id", "photo_id"], :name => "index_votes_on_voter_id_and_photo_id"
  add_index "votes", ["voter_id"], :name => "index_votes_on_voter_id"

end
