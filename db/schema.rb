# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_01_172127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "menu_items", force: :cascade do |t|
    t.bigint "menu_id"
    t.string "name"
    t.string "description"
    t.float "price"
    t.string "img_url"
    t.string "category"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.string "menu_url"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "menu_item_id"
    t.string "menu_item_name"
    t.float "menu_item_price"
    t.integer "quantity"
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id"
    t.boolean "success"
    t.boolean "delivered"
    t.datetime "delivered_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "password_digest"
    t.string "email"
    t.bigint "phone_number"
    t.string "address"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
