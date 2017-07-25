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

ActiveRecord::Schema.define(version: 20170725023041) do

  create_table "assignments", force: :cascade do |t|
    t.integer "timeslot_id_id"
    t.integer "boat_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boat_id_id"], name: "index_assignments_on_boat_id_id"
    t.index ["timeslot_id_id"], name: "index_assignments_on_timeslot_id_id"
  end

  create_table "boats", force: :cascade do |t|
    t.integer "capacity"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "timeslot_id_id"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["timeslot_id_id"], name: "index_bookings_on_timeslot_id_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.datetime "start_time"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
