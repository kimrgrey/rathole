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

ActiveRecord::Schema.define(version: 20150712004916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "bugs", force: true do |t|
    t.integer  "reporter_id",                     null: false
    t.integer  "post_id",                         null: false
    t.integer  "state",               default: 0
    t.text     "fragment"
    t.text     "fragment_html"
    t.text     "note"
    t.text     "note_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "note_updated_at"
    t.datetime "fragment_updated_at"
    t.integer  "comments_count"
  end

  add_index "bugs", ["post_id"], name: "index_bugs_on_post_id", using: :btree
  add_index "bugs", ["reporter_id"], name: "index_bugs_on_reporter_id", using: :btree

  create_table "claims", force: true do |t|
    t.text     "body",       default: ""
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "claims", ["email"], name: "index_claims_on_email", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_html"
    t.datetime "body_updated_at"
    t.datetime "deleted_at"
    t.integer  "parent_id",       null: false
    t.string   "parent_type",     null: false
  end

  add_index "comments", ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
  add_index "comments", ["parent_type", "parent_id"], name: "index_comments_on_parent_type_and_parent_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: true do |t|
    t.string   "type"
    t.hstore   "properties", default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "uuid",       null: false
    t.string   "provider",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree
  add_index "identities", ["uuid", "provider"], name: "index_identities_on_uuid_and_provider", using: :btree

  create_table "imports", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "lj_user"
    t.integer  "state",      default: 0
  end

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "token",      null: false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["target_id"], name: "index_invites_on_target_id", unique: true, using: :btree

  create_table "pictures", force: true do |t|
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     default: false
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "section_id"
    t.integer  "comments_count",     default: 0
    t.text     "tags",               default: [],    array: true
    t.integer  "state",              default: 0
    t.text     "body_html"
    t.text     "preview"
    t.text     "preview_html"
    t.boolean  "visible_on_main",    default: false
    t.datetime "published_at"
    t.datetime "body_updated_at"
    t.datetime "preview_updated_at"
    t.datetime "deleted_at"
  end

  add_index "posts", ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree
  add_index "posts", ["tags"], name: "index_posts_on_tags", using: :gin

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "posts_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickers", force: true do |t|
    t.string   "code"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickers_users", force: true do |t|
    t.integer "user_id"
    t.integer "sticker_id"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "subscriber_id"
    t.integer  "author_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "syncs", force: true do |t|
    t.datetime "lsd",                            null: false
    t.datetime "next_lsd",                       null: false
    t.integer  "post_id"
    t.string   "token",                          null: false
    t.integer  "attempts_count", default: 0,     null: false
    t.text     "result"
    t.boolean  "finished",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "syncs", ["token"], name: "index_syncs_on_token", unique: true, using: :btree

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name",                           null: false
    t.integer  "posts_count",            default: 0
    t.integer  "comments_count",         default: 0
    t.string   "avatar_path"
    t.text     "roles",                  default: [],              array: true
    t.text     "about"
    t.text     "about_html"
    t.integer  "bugs_count",             default: 0
    t.datetime "last_published_at"
    t.datetime "about_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true, using: :btree

end
