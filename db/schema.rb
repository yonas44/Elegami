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

ActiveRecord::Schema[7.0].define(version: 2023_09_01_151016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "milestones", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "title"
    t.string "status"
    t.date "due_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "project_users", force: :cascade do |t|
    t.string "role", default: "contributor"
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "priority"
    t.boolean "completed", default: false
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "description", null: false
    t.bigint "created_by_id", null: false
    t.bigint "assigned_to_id"
    t.bigint "milestone_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to_id"], name: "index_tasks_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["milestone_id"], name: "index_tasks_on_milestone_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "milestones", "projects"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "tasks", "milestones"
  add_foreign_key "tasks", "users", column: "assigned_to_id"
  add_foreign_key "tasks", "users", column: "created_by_id"
end
