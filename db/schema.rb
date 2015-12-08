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

ActiveRecord::Schema.define(version: 20151206201236) do

  create_table "advertisings", force: :cascade do |t|
    t.string   "advertise_info"
    t.binary   "image"
    t.date     "contract_date"
    t.integer  "inc_account_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "advertisings", ["inc_account_id"], name: "index_advertisings_on_inc_account_id"

  create_table "distances", force: :cascade do |t|
    t.integer  "distance"
    t.integer  "facility_id"
    t.integer  "housing_id"
    t.integer  "store_id"
    t.integer  "inc_account_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "distances", ["facility_id"], name: "index_distances_on_facility_id"
  add_index "distances", ["housing_id"], name: "index_distances_on_housing_id"
  add_index "distances", ["inc_account_id"], name: "index_distances_on_inc_account_id"
  add_index "distances", ["store_id"], name: "index_distances_on_store_id"

  create_table "facilities", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "inc_account_id"
    t.integer  "store_id"
    t.integer  "housing_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "favorites", ["housing_id"], name: "index_favorites_on_housing_id"
  add_index "favorites", ["inc_account_id"], name: "index_favorites_on_inc_account_id"
  add_index "favorites", ["store_id"], name: "index_favorites_on_store_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "housings", force: :cascade do |t|
    t.string   "street_address"
    t.integer  "rent"
    t.integer  "administration_cost"
    t.string   "housing_type"
    t.date     "building_date"
    t.string   "direction"
    t.string   "layout"
    t.integer  "area"
    t.string   "structure"
    t.integer  "floor"
    t.integer  "deposit"
    t.integer  "recompense"
    t.integer  "security_money"
    t.integer  "shikibiki"
    t.integer  "insurance"
    t.integer  "parking"
    t.string   "trading_aspect"
    t.integer  "another_cost"
    t.string   "vacancy"
    t.string   "detail"
    t.integer  "plan"
    t.date     "contract_update"
    t.integer  "views"
    t.integer  "favorites"
    t.binary   "image"
    t.integer  "inc_account_id"
    t.integer  "store_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "housings", ["inc_account_id"], name: "index_housings_on_inc_account_id"
  add_index "housings", ["store_id"], name: "index_housings_on_store_id"

  create_table "inc_accounts", force: :cascade do |t|
    t.string   "inc_name"
    t.string   "password_digest"
    t.string   "mail_address"
    t.string   "phone_num"
    t.string   "account_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "avaliable"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "store_name"
    t.string   "street_address"
    t.string   "postal_code"
    t.integer  "inc_account_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "stores", ["inc_account_id"], name: "index_stores_on_inc_account_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password_digest"
    t.string   "mail_address"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "avaliable"
  end

end
