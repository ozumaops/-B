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

ActiveRecord::Schema.define(version: 20221113090648) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "restarted_at"
    t.datetime "refinished_at"
    t.time "overwork_end_time"
    t.boolean "next_day"
    t.boolean "overwork_next_day"
    t.string "note"
    t.string "overwork_status"
    t.string "overwork_approval_status"
    t.string "attendance_change_status"
    t.string "attendance_change_check_status"
    t.string "one_month_approval_status"
    t.string "one_month_approval_check_status"
    t.string "process_content"
    t.string "superior_confirmation"
    t.string "superior_notice_confirmation"
    t.string "superior_attendance_change_confirmation"
    t.string "superior_attendance_change_approval_confirmation"
    t.string "superior_month_notice_confirmation"
    t.string "superior_month_approval_confirmation"
    t.boolean "is_check"
    t.boolean "change_check"
    t.boolean "approval_check"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "begin_started"
    t.datetime "begin_finished"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.integer "base_number"
    t.string "base_branch"
    t.string "work_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "employee_number"
    t.integer "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.datetime "basic_work_time", default: "2023-01-21 23:00:00"
    t.datetime "work_time", default: "2023-01-21 22:30:00"
    t.time "designated_work_start_time", default: "2000-01-01 23:00:00"
    t.time "designated_work_end_time", default: "2000-01-01 08:00:00"
    t.string "affiliation"
    t.boolean "superior", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
