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

ActiveRecord::Schema.define(version: 20181221115900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "shopify_id"
    t.string   "email"
    t.string   "address"
    t.boolean  "accept_marketing",       default: true
    t.datetime "created_at_shopify"
    t.datetime "updated_at_shopify"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "shopify_orders_count"
    t.string   "state"
    t.float    "total_spent"
    t.string   "last_order_id"
    t.boolean  "verified_shopify_email", default: false
    t.boolean  "tax_exempt_shopify",     default: false
    t.string   "phone"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint   "order_uuid"
    t.string   "shipping_title"
    t.datetime "order_date"
    t.string   "order_status"
    t.string   "payment_status"
    t.string   "customer_email"
    t.string   "customer_phone"
    t.string   "total_amount"
    t.string   "shipping_address"
    t.string   "billing_address"
    t.boolean  "local_status",     default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "shopify_id"
    t.string   "email"
    t.string   "name"
    t.datetime "closed_at_shopify"
    t.datetime "created_at_shopify"
    t.datetime "updated_at_shopify"
    t.string   "shopify_token"
    t.string   "shopify_number"
    t.string   "shopify_gateway"
    t.boolean  "test",                      default: false
    t.float    "total_price"
    t.float    "subtotal_price"
    t.float    "total_tax"
    t.boolean  "taxes_included",            default: false
    t.string   "financial_status"
    t.boolean  "confirmed",                 default: true
    t.datetime "cancelled_at"
    t.string   "cancel_reason"
    t.string   "shopify_user_id"
    t.string   "shopify_location_id"
    t.string   "shopify_contact_email"
    t.string   "shopify_order_number"
    t.string   "shopify_order_status_url"
    t.string   "shopify_source_name"
    t.string   "shopify_processing_method"
    t.integer  "customer_id"
    t.text     "payment_gateway_names",     default: [],                 array: true
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  end

  create_table "product_details", force: :cascade do |t|
    t.integer  "order_detail_id"
    t.string   "sku"
    t.string   "name"
    t.string   "quantity"
    t.string   "price"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "product_properties", force: :cascade do |t|
    t.integer  "product_detail_id"
    t.string   "property_key"
    t.string   "property_value"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.float    "price"
    t.float    "compare_price"
    t.boolean  "shipping",                     default: false
    t.float    "weight"
    t.boolean  "tax",                          default: false
    t.boolean  "allow_buying_if_out_of_stock", default: false
    t.string   "shopify_id"
    t.integer  "shop_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["shop_id"], name: "index_products_on_shop_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id", using: :btree
  end

  create_table "shops", force: :cascade do |t|
    t.string   "shopify_domain", null: false
    t.string   "shopify_token",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id", using: :btree
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
    t.index ["user_id"], name: "index_users_roles_on_user_id", using: :btree
  end

end
