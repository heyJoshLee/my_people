# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160612091558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.text     "body"
    t.string   "announceable_type"
    t.integer  "announceable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "categorizable_type"
    t.integer  "categorizable_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "zip_code"
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "description"
    t.datetime "date_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "slug"
    t.string   "img"
    t.string   "cover_img"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "category_id"
    t.string   "zip_code"
    t.string   "cover_img"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "going"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.string  "password_digest"
    t.string  "slug"
    t.text    "profile_description"
    t.boolean "private_profile"
    t.string  "role"
    t.string  "profile_img"
  end

end
