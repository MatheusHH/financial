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

ActiveRecord::Schema.define(version: 2020_03_04_190755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "agency_number"
    t.string "account_number"
    t.string "bank"
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "BRL", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "schedule"
    t.text "description"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "limit_value_cents", default: 0, null: false
    t.string "limit_value_currency", default: "BRL", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "card_name"
    t.integer "balance_card_cents", default: 0, null: false
    t.string "balance_card_currency", default: "BRL", null: false
    t.integer "closing_day"
    t.integer "invoice_day"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "expense_cards", force: :cascade do |t|
    t.date "invoice_date"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.integer "status"
    t.bigint "card_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expense_times"
    t.index ["card_id"], name: "index_expense_cards_on_card_id"
    t.index ["user_id"], name: "index_expense_cards_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.date "duedate"
    t.bigint "category_id"
    t.bigint "supplier_id"
    t.integer "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_expenses_on_account_id"
    t.index ["category_id"], name: "index_expenses_on_category_id"
    t.index ["supplier_id"], name: "index_expenses_on_supplier_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.date "receipt_date"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "kind_id"
    t.bigint "source_id"
    t.index ["account_id"], name: "index_incomes_on_account_id"
    t.index ["kind_id"], name: "index_incomes_on_kind_id"
    t.index ["source_id"], name: "index_incomes_on_source_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "kinds", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_kinds_on_user_id"
  end

  create_table "payment_cards", force: :cascade do |t|
    t.date "invoice_payment_date"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.bigint "card_id"
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payment_cards_on_account_id"
    t.index ["card_id"], name: "index_payment_cards_on_card_id"
    t.index ["user_id"], name: "index_payment_cards_on_user_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sources_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "sender_account"
    t.integer "receiver_account"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "appointments", "users"
  add_foreign_key "cards", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "expense_cards", "cards"
  add_foreign_key "expense_cards", "users"
  add_foreign_key "expenses", "accounts"
  add_foreign_key "expenses", "categories"
  add_foreign_key "expenses", "suppliers"
  add_foreign_key "expenses", "users"
  add_foreign_key "incomes", "accounts"
  add_foreign_key "incomes", "kinds"
  add_foreign_key "incomes", "sources"
  add_foreign_key "incomes", "users"
  add_foreign_key "kinds", "users"
  add_foreign_key "payment_cards", "accounts"
  add_foreign_key "payment_cards", "cards"
  add_foreign_key "payment_cards", "users"
  add_foreign_key "sources", "users"
  add_foreign_key "suppliers", "users"
  add_foreign_key "transfers", "users"
end
