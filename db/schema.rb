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
    t.integer  "num_votes"
    t.datetime "election_time"
    t.boolean  "did_win"
    t.integer  "phase" #0 adding positions 1: nomination 2:voting 3: closed
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
    t.string  "prime_product" # integer? yeah there's a gem for dis
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
    t.integer "admin_status" #0: member #1: admin #2: super-admin
    t.integer "user_prime"
    t.string  "votes" #all the people they've voted for
    t.boolean "has_voted" #this is okay because only 1 election of a org can happen at once. Reset to false at end of election of a position
  end

end
