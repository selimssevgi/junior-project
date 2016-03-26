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

ActiveRecord::Schema.define(version: 20160326131132) do

  create_table "casts", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.integer  "person_id",  limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "casts", ["movie_id"], name: "index_casts_on_movie_id", using: :btree
  add_index "casts", ["person_id"], name: "index_casts_on_person_id", using: :btree
  add_index "casts", ["role_id"], name: "index_casts_on_role_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "country_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "country_movies", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.integer  "country_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "country_movies", ["country_id"], name: "index_country_movies_on_country_id", using: :btree
  add_index "country_movies", ["movie_id"], name: "index_country_movies_on_movie_id", using: :btree

  create_table "genremovies", force: :cascade do |t|
    t.integer  "genre_id",   limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "genremovies", ["genre_id"], name: "index_genremovies_on_genre_id", using: :btree
  add_index "genremovies", ["movie_id"], name: "index_genremovies_on_movie_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "genre",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "language_movies", force: :cascade do |t|
    t.integer  "movie_id",    limit: 4
    t.integer  "language_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "language_movies", ["language_id"], name: "index_language_movies_on_language_id", using: :btree
  add_index "language_movies", ["movie_id"], name: "index_language_movies_on_movie_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "language",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "year",        limit: 4
    t.string   "released",    limit: 255
    t.integer  "runtime",     limit: 4
    t.text     "plot",        limit: 65535
    t.string   "awards",      limit: 255
    t.string   "poster",      limit: 255
    t.integer  "metascore",   limit: 4
    t.decimal  "imdb_rating",               precision: 3, scale: 1
    t.integer  "imdb_votes",  limit: 4
    t.string   "imdb_id",     limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "rated_id",    limit: 4
  end

  add_index "movies", ["rated_id"], name: "index_movies_on_rated_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "full_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rateds", force: :cascade do |t|
    t.string   "rated",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_type",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest", limit: 255
    t.string   "remember_digest", limit: 255
    t.boolean  "admin",                       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "watchedlists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "watchedlists", ["movie_id"], name: "index_watchedlists_on_movie_id", using: :btree
  add_index "watchedlists", ["user_id"], name: "index_watchedlists_on_user_id", using: :btree

  create_table "watchlists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "watchlists", ["movie_id"], name: "index_watchlists_on_movie_id", using: :btree
  add_index "watchlists", ["user_id"], name: "index_watchlists_on_user_id", using: :btree

  add_foreign_key "casts", "movies"
  add_foreign_key "casts", "people"
  add_foreign_key "casts", "roles"
  add_foreign_key "country_movies", "countries"
  add_foreign_key "country_movies", "movies"
  add_foreign_key "genremovies", "genres"
  add_foreign_key "genremovies", "movies"
  add_foreign_key "language_movies", "languages"
  add_foreign_key "language_movies", "movies"
  add_foreign_key "movies", "rateds"
  add_foreign_key "watchedlists", "movies"
  add_foreign_key "watchedlists", "users"
  add_foreign_key "watchlists", "movies"
  add_foreign_key "watchlists", "users"
end
