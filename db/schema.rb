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

ActiveRecord::Schema.define(:version => 20101027123117) do

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "estimate"
    t.datetime "create_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "story_status_id", :default => 1, :null => false
  end

  create_table "story_statuses", :force => true do |t|
    t.string   "title",       :null => false
    t.datetime "create_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
