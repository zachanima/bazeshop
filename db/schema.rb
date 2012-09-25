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

ActiveRecord::Schema.define(:version => 20120925225544) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "shop_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent_id"
    t.integer  "position"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["shop_id"], :name => "index_categories_on_shop_id"

  create_table "images", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "product_id"
    t.string   "image"
    t.integer  "position"
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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "options", ["option_group_id"], :name => "index_options_on_option_group_id"

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
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "link"
    t.string   "locale"
    t.string   "login_text"
    t.string   "password_text"
    t.text     "text"
    t.string   "currency"
    t.string   "border_style"
    t.string   "link_style"
    t.string   "custom_style"
    t.text     "receipt_text"
    t.string   "correspondent"
    t.decimal  "shipping_price",     :precision => 8, :scale => 2
    t.decimal  "free_shipping_over", :precision => 8, :scale => 2
    t.boolean  "is_closed"
    t.string   "logo"
  end

end
