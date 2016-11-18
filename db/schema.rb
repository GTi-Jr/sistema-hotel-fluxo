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

ActiveRecord::Schema.define(version: 20161118035905) do

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "", null: false
    t.string   "code",                   limit: 255
    t.boolean  "admin"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "sector_id",              limit: 4
    t.integer  "department_id",          limit: 4
  end

  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree
  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
  add_index "employees", ["sector_id"], name: "index_employees_on_sector_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "code",          limit: 4
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.integer  "sector_id",     limit: 4
    t.integer  "department_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "price",         limit: 24
  end

  add_index "products", ["department_id"], name: "index_products_on_department_id", using: :btree
  add_index "products", ["sector_id"], name: "index_products_on_sector_id", using: :btree

  create_table "sectors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "payment_method", limit: 4
    t.integer  "quantity",       limit: 4
    t.string   "client_code",    limit: 255
    t.date     "data_t"
    t.integer  "employee_id",    limit: 4
    t.boolean  "status_t",                   default: true
    t.integer  "product_code",   limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "type_t",         limit: 4
    t.float    "price",          limit: 24
  end

  add_index "transactions", ["employee_id"], name: "index_transactions_on_employee_id", using: :btree

  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "sectors"
  add_foreign_key "products", "departments"
  add_foreign_key "products", "sectors"
  add_foreign_key "transactions", "employees"
end
