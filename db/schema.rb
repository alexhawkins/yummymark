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

ActiveRecord::Schema.define(version: 20140505195631) do

  create_table "bookmarks", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "bookmarks_topics", id: false, force: true do |t|
    t.integer "bookmark_id"
    t.integer "topic_id"
  end

  add_index "bookmarks_topics", ["bookmark_id"], name: "index_bookmarks_topics_on_bookmark_id"
  add_index "bookmarks_topics", ["topic_id"], name: "index_bookmarks_topics_on_topic_id"

  create_table "topics", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
