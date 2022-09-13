# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_13_221541) do

  create_table "comments", charset: "utf8mb4", force: :cascade do |t|
    t.string "uuid", null: false
    t.text "body", null: false
    t.bigint "diary_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_id"], name: "index_comments_on_diary_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "diaries", charset: "utf8mb4", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "recommended_member_id", null: false
    t.string "event_name"
    t.date "event_date"
    t.string "event_venue"
    t.integer "event_polaroid_count"
    t.string "impressive_memory"
    t.text "impressive_memory_detail"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["created_at"], name: "index_diaries_on_created_at"
    t.index ["recommended_member_id", "created_at"], name: "index_diaries_on_recommended_member_id_and_created_at"
    t.index ["recommended_member_id"], name: "index_diaries_on_recommended_member_id"
    t.index ["user_id"], name: "index_diaries_on_user_id"
    t.index ["uuid"], name: "index_diaries_on_uuid", unique: true
  end

  create_table "diary_images", charset: "utf8mb4", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "diary_id", null: false
    t.string "diary_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_id"], name: "index_diary_images_on_diary_id"
    t.index ["uuid"], name: "index_diary_images_on_uuid", unique: true
  end

  create_table "notifications", charset: "utf8mb4", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "notifier_id", null: false
    t.bigint "notified_id", null: false
    t.bigint "diary_id"
    t.bigint "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["diary_id"], name: "index_notifications_on_diary_id"
    t.index ["notified_id"], name: "index_notifications_on_notified_id"
    t.index ["notifier_id"], name: "index_notifications_on_notifier_id"
    t.index ["uuid"], name: "index_notifications_on_uuid", unique: true
  end

  create_table "recommended_members", charset: "utf8mb4", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "user_id", null: false
    t.string "nickname", null: false
    t.string "group"
    t.date "first_met_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_recommended_members_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_recommended_members_on_user_id"
    t.index ["uuid"], name: "index_recommended_members_on_uuid", unique: true
  end

  create_table "user_relationships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "follow_id", null: false
    t.bigint "follower_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uuid", null: false
    t.index ["follow_id", "follower_id"], name: "index_user_relationships_on_follow_id_and_follower_id", unique: true
    t.index ["follow_id"], name: "index_user_relationships_on_follow_id"
    t.index ["follower_id"], name: "index_user_relationships_on_follower_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "sub", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.text "user_image"
    t.string "uuid", null: false
    t.text "me_introduction"
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["sub"], name: "index_users_on_sub", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "comments", "diaries"
  add_foreign_key "comments", "users"
  add_foreign_key "diaries", "recommended_members"
  add_foreign_key "diaries", "users"
  add_foreign_key "diary_images", "diaries"
  add_foreign_key "notifications", "comments"
  add_foreign_key "notifications", "diaries"
  add_foreign_key "notifications", "users", column: "notified_id"
  add_foreign_key "notifications", "users", column: "notifier_id"
  add_foreign_key "recommended_members", "users"
  add_foreign_key "user_relationships", "users", column: "follow_id"
  add_foreign_key "user_relationships", "users", column: "follower_id"
end
