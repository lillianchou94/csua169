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

ActiveRecord::Schema.define(version: 20160312000005) do

  create_table "elections", force: :cascade do |t|
    t.integer  "users_id"
    t.string   "election_name"
    t.string   "election_id"
    t.string   "election_livestream"
    t.string   "organization"
    t.string   "position"
    t.string   "user_id"
    t.datetime "election_time"
    t.integer  "phase"
    t.string   "created_by"
  end

  create_table "nominations", force: :cascade do |t|
    t.integer "users_id"
    t.string  "election_id"
    t.string  "organization"
    t.string  "user_id"
    t.integer "threshold"
    t.string  "position"
    t.integer "num_seconds"
    t.integer "prime_product"
    t.integer "num_votes"
    t.boolean "did_win"
  end

  create_table "users", force: :cascade do |t|
    t.string  "user_name"
    t.boolean "is_active"
    t.string  "provider"
    t.string  "uid"
    t.string  "oauth_token"
    t.string  "oauth_expires_at"
    t.string  "user_email"
    t.string  "organization"
    t.integer "admin_status"
    t.integer "user_prime"
    t.string  "votes"
    t.boolean "has_voted"
  end

end
