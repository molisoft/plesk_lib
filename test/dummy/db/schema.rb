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

ActiveRecord::Schema.define(:version => 20130917020158) do

  create_table "plesk_kit_customer_accounts", :force => true do |t|
    t.string   "cname"
    t.string   "pname"
    t.string   "login"
    t.string   "passwd"
    t.integer  "server_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plesk_kit_customers", :force => true do |t|
    t.string   "fist_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plesk_kit_reseller_accounts", :force => true do |t|
    t.string   "cname"
    t.string   "pname"
    t.string   "login"
    t.string   "passwd"
    t.integer  "server_id"
    t.integer  "service_plan_id"
    t.string   "plan_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "plesk_kit_servers", :force => true do |t|
    t.string   "environment"
    t.string   "host"
    t.string   "username"
    t.string   "password"
    t.string   "ghostname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plesk_kit_service_plans", :force => true do |t|
    t.string   "name"
    t.string   "domains"
    t.string   "traffic"
    t.string   "mailboxes"
    t.string   "storage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plesk_kit_subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "owner_id"
    t.string   "owner_login"
    t.string   "ip_address"
    t.string   "plan_name"
    t.integer  "service_plan_id"
    t.integer  "customer_account_id"
    t.integer  "reseller_account_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "plesk_kit_webspaces", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
