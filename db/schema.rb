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

ActiveRecord::Schema.define(:version => 20140907225458) do

  create_table "libraries", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description"
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "img_url"
  end

  add_index "libraries", ["user_id"], :name => "index_libraries_on_user_id"

  create_table "paragraphs", :force => true do |t|
    t.integer  "position"
    t.integer  "reading_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "paragraphs", ["reading_id"], :name => "index_paragraphs_on_reading_id"

  create_table "phrases", :force => true do |t|
    t.string   "text",        :null => false
    t.integer  "position"
    t.integer  "sentence_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "phrases", ["sentence_id"], :name => "index_phrases_on_sentence_id"

  create_table "poems", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "poems", ["user_id"], :name => "index_poems_on_user_id"

  create_table "readings", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "content",     :null => false
    t.string   "author"
    t.string   "summary"
    t.integer  "rating"
    t.boolean  "sentencely"
    t.boolean  "phrasely"
    t.boolean  "paragraphly"
    t.integer  "library_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "source"
  end

  add_index "readings", ["library_id"], :name => "index_readings_on_library_id"

  create_table "sentences", :force => true do |t|
    t.integer  "position"
    t.integer  "paragraph_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "sentences", ["paragraph_id"], :name => "index_sentences_on_paragraph_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
