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

ActiveRecord::Schema.define(version: 20151108012254) do

  create_table "repos", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "repos_words", id: false, force: :cascade do |t|
    t.integer "repo_id", null: false
    t.integer "word_id", null: false
  end

  add_index "repos_words", ["repo_id", "word_id"], name: "index_repos_words_on_repo_id_and_word_id"
  add_index "repos_words", ["word_id", "repo_id"], name: "index_repos_words_on_word_id_and_repo_id"

  create_table "words", force: :cascade do |t|
    t.string   "name"
    t.integer  "uses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
