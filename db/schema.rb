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

ActiveRecord::Schema[7.1].define(version: 2023_08_20_052319) do
  create_schema "crdb_internal"

  create_table "active_storage_attachments", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.unique_constraint ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness"
  end

  create_table "active_storage_blobs", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false

    t.unique_constraint ["key"], name: "index_active_storage_blobs_on_key"
  end

  create_table "active_storage_variant_records", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false

    t.unique_constraint ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness"
  end

  create_table "app_settings", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.unique_constraint ["key"], name: "index_app_settings_on_key"
  end

  create_table "plans", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "crm_id"
    t.float "price", null: false
    t.string "currency", null: false
    t.jsonb "description"
    t.string "duration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.string "type"
    t.jsonb "permissions", default: "{}", null: false
    t.bigint "space_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_roles_on_space_id"
  end

  create_table "spaces", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.bigint "status"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "space_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.bigint "seats"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["space_id"], name: "index_subscriptions_on_space_id"
  end

  create_table "user_roles", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "space_id", null: false
    t.bigint "role_id", null: false

    t.unique_constraint ["user_id", "space_id"], name: "index_user_roles_on_user_id_and_space_id"
  end

  create_table "users", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.bigint "status", default: 0
    t.string "session_token"
    t.boolean "admin", default: false
    t.string "color_scheme"
    t.string "color_mode"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.bigint "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.bigint "invitations_count", default: 0
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.unique_constraint ["email"], name: "index_users_on_email"
    t.unique_constraint ["invitation_token"], name: "index_users_on_invitation_token"
    t.unique_constraint ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "roles", "spaces"
end
