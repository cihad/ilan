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

ActiveRecord::Schema.define(version: 20140103234324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "node_id"
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["node_id"], name: "index_images_on_node_id", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "contact"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.integer  "category_id"
    t.string   "status"
  end

  add_index "nodes", ["category_id"], name: "index_nodes_on_category_id", using: :btree
  add_index "nodes", ["city_id"], name: "index_nodes_on_city_id", using: :btree

end
