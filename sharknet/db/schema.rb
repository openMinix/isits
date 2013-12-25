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

ActiveRecord::Schema.define(version: 20131225224343) do

  create_table "activities", force: true do |t|
    t.string   "type_activity"
    t.string   "description"
    t.integer  "work_hours"
    t.boolean  "extra"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sheetfile_id"
  end

  add_index "activities", ["sheetfile_id"], name: "index_activities_on_sheetfile_id"

  create_table "clients", force: true do |t|
    t.string   "client_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "dept_name"
    t.integer  "division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["division_id"], name: "index_departments_on_division_id"

  create_table "divisions", force: true do |t|
    t.string   "div_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "project_name"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id"

  create_table "sheetfiles", force: true do |t|
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timesheet_id"
  end

  add_index "sheetfiles", ["timesheet_id"], name: "index_sheetfiles_on_timesheet_id"

  create_table "timesheets", force: true do |t|
    t.string   "status"
    t.date     "period"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "timesheets", ["user_id"], name: "index_timesheets_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_fullname"
    t.string   "user_job"
    t.integer  "department_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
