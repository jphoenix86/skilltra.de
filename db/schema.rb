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

ActiveRecord::Schema.define(version: 20141025223132) do

  create_table "accounts", force: true do |t|
    t.string   "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "company"
    t.string   "primarySkill"
    t.string   "secondarySkill"
    t.boolean  "completed"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "bids", force: true do |t|
    t.integer  "bid"
    t.string   "bidinfo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "user_id"
  end

  add_index "bids", ["post_id"], name: "index_bids_on_post_id"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "bid_user_id"
    t.boolean  "completed"
  end

  add_index "jobs", ["post_id"], name: "index_jobs_on_post_id"
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id"

  create_table "posts", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.string   "category"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "reviews", force: true do |t|
    t.integer "score"
    t.integer "reviewee_id"
    t.integer "reviewer_id"
    t.integer "job_id"
  end

  add_index "reviews", ["job_id"], name: "index_reviews_on_job_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "company"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.integer  "balance"
    t.float    "average_score"
    t.boolean  "account_completed"
    t.integer  "jobs_completed"
    t.integer  "open_jobs"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
