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

ActiveRecord::Schema[8.1].define(version: 2025_12_28_031745) do
  create_table "app_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.json "settings", default: {}, null: false
    t.datetime "updated_at", null: false
    t.index ["settings"], name: "index_app_settings_on_settings"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "crm_id"
    t.string "currency", null: false
    t.string "description"
    t.string "duration", null: false
    t.string "name", null: false
    t.float "price", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.json "permissions", default: "{}", null: false
    t.integer "space_id"
    t.string "type"
    t.datetime "updated_at", null: false
    t.string "value"
    t.index ["space_id"], name: "index_roles_on_space_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "end_date"
    t.integer "plan_id", null: false
    t.integer "seats"
    t.integer "space_id", null: false
    t.datetime "start_date", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["space_id"], name: "index_subscriptions_on_space_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "space_id", null: false
    t.integer "user_id", null: false
    t.index ["user_id", "space_id"], name: "index_user_roles_on_user_id_and_space_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.datetime "invitation_accepted_at"
    t.datetime "invitation_created_at"
    t.integer "invitation_limit"
    t.datetime "invitation_sent_at"
    t.string "invitation_token"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.string "last_name"
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "session_token"
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "roles", "spaces"
end
