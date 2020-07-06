# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_03_075452) do

  create_table "tweets", force: :cascade do |t|
    t.integer "twitter_thread_id"
    t.string "content"
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["twitter_thread_id"], name: "index_tweets_on_twitter_thread_id"
  end

  create_table "twitter_threads", force: :cascade do |t|
    t.datetime "scheduled_at"
    t.datetime "posted_at"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_twitter_threads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "uid", null: false
    t.string "provider", null: false
    t.string "name", null: false
    t.string "nickname", null: false
    t.boolean "is_locked", default: false
    t.boolean "is_admin", default: false
    t.string "timezone", default: "UTC"
    t.string "access_token"
    t.string "access_token_secret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
