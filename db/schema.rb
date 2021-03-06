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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141111035545) do

  create_table "access_groups", :force => true do |t|
    t.string   "name"
    t.integer  "shop_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "access_groups_categories", :id => false, :force => true do |t|
    t.integer "access_group_id"
    t.integer "category_id"
  end

  create_table "access_groups_users", :id => false, :force => true do |t|
    t.integer "access_group_id"
    t.integer "user_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "shop_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "reorder_period"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["shop_id"], :name => "index_categories_on_shop_id"

  create_table "category_user_order_dates", :force => true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.date     "order_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "category_user_order_dates", ["category_id"], :name => "index_category_user_order_dates_on_category_id"
  add_index "category_user_order_dates", ["user_id"], :name => "index_category_user_order_dates_on_user_id"

  create_table "fields", :force => true do |t|
    t.string   "text"
    t.boolean  "required"
    t.integer  "shop_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "is_receipt_email"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "product_id"
    t.string   "image"
    t.integer  "position"
  end

  create_table "line_items", :force => true do |t|
    t.string   "product_name"
    t.string   "product_number"
    t.string   "product_supplier_number"
    t.string   "product_brand"
    t.decimal  "gross_price",             :precision => 8, :scale => 2
    t.decimal  "net_price",               :precision => 8, :scale => 2
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.decimal  "product_gross_price",     :precision => 8, :scale => 2
    t.decimal  "product_net_price",       :precision => 8, :scale => 2
  end

  create_table "option_groups", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "option_set_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "option_sets", :force => true do |t|
    t.string   "name"
    t.boolean  "optional"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "text"
  end

  create_table "options", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "option_group_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.decimal  "net_price",       :precision => 8, :scale => 2
    t.decimal  "gross_price",     :precision => 8, :scale => 2
  end

  add_index "options", ["option_group_id"], :name => "index_options_on_option_group_id"

  create_table "orders", :force => true do |t|
    t.string   "user_name"
    t.decimal  "gross_price",    :precision => 8, :scale => 2
    t.decimal  "net_price",      :precision => 8, :scale => 2
    t.integer  "user_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.text     "comment"
    t.text     "fields"
    t.string   "transaction_id"
    t.float    "payment"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "number"
    t.string   "supplier_number"
    t.string   "brand"
    t.text     "text"
    t.decimal  "gross_price",     :precision => 8, :scale => 2
    t.decimal  "net_price",       :precision => 8, :scale => 2
    t.decimal  "environment_fee", :precision => 8, :scale => 2
    t.integer  "parcel_size"
    t.integer  "position"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.string   "link"
    t.string   "locale"
    t.string   "login_text"
    t.string   "password_text"
    t.text     "text"
    t.string   "currency"
    t.string   "header_style"
    t.string   "link_style"
    t.string   "custom_style"
    t.text     "receipt_text"
    t.string   "correspondent"
    t.decimal  "shipping_price",                  :precision => 8, :scale => 2
    t.decimal  "free_shipping_over",              :precision => 8, :scale => 2
    t.boolean  "is_closed"
    t.string   "logo"
    t.boolean  "reject_order_on_exceeded_budget"
    t.boolean  "allow_payment"
    t.text     "terms"
    t.boolean  "add_vat"
    t.boolean  "allow_proxy_orders"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                             :default => "", :null => false
    t.string   "encrypted_password",                                :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.string   "login"
    t.integer  "shop_id"
    t.string   "plaintext_password"
    t.string   "department"
    t.string   "name"
    t.string   "phone"
    t.text     "address"
    t.text     "text"
    t.boolean  "is_manager"
    t.integer  "manager_id"
    t.decimal  "budget",              :precision => 8, :scale => 2
    t.decimal  "balance",             :precision => 8, :scale => 2
    t.boolean  "is_demo"
    t.boolean  "is_catalogue"
    t.text     "fields"
    t.boolean  "superuser"
    t.boolean  "is_active"
  end

  create_table "variants", :force => true do |t|
    t.decimal  "net_price",   :precision => 8, :scale => 2
    t.decimal  "gross_price", :precision => 8, :scale => 2
    t.integer  "option_id"
    t.integer  "product_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "variants", ["option_id"], :name => "index_variants_on_option_id"
  add_index "variants", ["product_id"], :name => "index_variants_on_product_id"

  create_table "variations", :force => true do |t|
    t.string   "option_set_name"
    t.string   "option_name"
    t.decimal  "gross_price",     :precision => 8, :scale => 2
    t.decimal  "net_price",       :precision => 8, :scale => 2
    t.integer  "variant_id"
    t.integer  "line_item_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "variations", ["line_item_id"], :name => "index_variations_on_line_item_id"
  add_index "variations", ["variant_id"], :name => "index_variations_on_variant_id"

end
