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

ActiveRecord::Schema.define(version: 20171208083016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "postcode"
    t.string   "city"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "country_code"
  end

  create_table "artworks", force: :cascade do |t|
    t.decimal "price", precision: 10, scale: 2
  end

  create_table "attributes", force: :cascade do |t|
    t.string   "title_en"
    t.text     "value_en"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title_fr"
    t.string   "title_es"
    t.string   "value_fr"
    t.string   "value_es"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name_en"
    t.integer  "father_category_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name_fr"
    t.string   "name_es"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description_en"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "description_fr"
    t.text     "description_es"
  end

  create_table "companies_countries", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "companies_countries", ["company_id"], name: "index_companies_countries_on_company_id", using: :btree
  add_index "companies_countries", ["country_id"], name: "index_companies_countries_on_country_id", using: :btree

  create_table "constructions", force: :cascade do |t|
    t.string  "name"
    t.decimal "price", precision: 10, scale: 2
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "country_code"
    t.integer  "region_id"
    t.integer  "currency_id"
    t.integer  "language_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "countries", ["currency_id"], name: "index_countries_on_currency_id", using: :btree
  add_index "countries", ["language_id"], name: "index_countries_on_language_id", using: :btree
  add_index "countries", ["region_id"], name: "index_countries_on_region_id", using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.float    "exchange_rate"
    t.string   "sign"
    t.string   "code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dimensions", force: :cascade do |t|
    t.string   "text"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "distributors", force: :cascade do |t|
    t.text     "information_en"
    t.string   "phone"
    t.string   "url"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "information_fr"
    t.text     "information_es"
  end

  create_table "father_categories", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_fr"
    t.string   "name_es"
  end

  create_table "filter_options", force: :cascade do |t|
    t.integer  "filter_id"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_fr"
    t.string   "name_es"
  end

  add_index "filter_options", ["filter_id"], name: "index_filter_options_on_filter_id", using: :btree

  create_table "filter_options_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "filter_option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filter_options_products", ["filter_option_id"], name: "index_filter_options_products_on_filter_option_id", using: :btree
  add_index "filter_options_products", ["product_id"], name: "index_filter_options_products_on_product_id", using: :btree

  create_table "filters", force: :cascade do |t|
    t.integer  "sub_category_id"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_fr"
    t.string   "name_es"
  end

  add_index "filters", ["sub_category_id"], name: "index_filters_on_sub_category_id", using: :btree

  create_table "fin_systems", force: :cascade do |t|
    t.string  "name"
    t.decimal "price", precision: 10, scale: 2
  end

  create_table "guide_images", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guides", force: :cascade do |t|
    t.string   "header_en"
    t.text     "description_en"
    t.string   "video_url_en"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "sub_category_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "video_url_fr"
    t.string   "video_url_es"
    t.string   "header_fr"
    t.string   "header_es"
    t.text     "description_fr"
    t.text     "description_es"
  end

  add_index "guides", ["sub_category_id"], name: "index_guides_on_sub_category_id", using: :btree

  create_table "info_abouts", force: :cascade do |t|
    t.string   "header_en"
    t.text     "description_en"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "header_fr"
    t.string   "header_es"
    t.text     "description_fr"
    t.text     "description_es"
  end

  create_table "info_privacies", force: :cascade do |t|
    t.string   "header"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "info_questions", force: :cascade do |t|
    t.string   "header_en"
    t.text     "description_en"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "header_fr"
    t.string   "header_es"
    t.text     "description_fr"
    t.text     "description_es"
  end

  create_table "info_terms", force: :cascade do |t|
    t.string   "header"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_fr"
    t.string   "name_es"
  end

  create_table "photos", force: :cascade do |t|
    t.boolean  "main"
    t.text     "comment"
    t.boolean  "day"
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "pos", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "distributor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "prices", force: :cascade do |t|
    t.float    "amount"
    t.integer  "currency_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description_en"
    t.integer  "year"
    t.integer  "sub_category_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "company_id"
    t.text     "description_fr"
    t.text     "description_es"
    t.string   "slug"
    t.string   "blue_tomato_product_code"
  end

  add_index "products", ["blue_tomato_product_code"], name: "index_products_on_blue_tomato_product_code", unique: true, using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "review_id"
  end

  create_table "region_product_urls", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "product_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "region_product_urls", ["product_id", "region_id"], name: "index_region_product_urls_on_product_id_and_region_id", unique: true, using: :btree
  add_index "region_product_urls", ["product_id"], name: "index_region_product_urls_on_product_id", using: :btree
  add_index "region_product_urls", ["region_id"], name: "index_region_product_urls_on_region_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "review"
    t.integer  "language_id"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "searches", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "size_heights", force: :cascade do |t|
    t.string "height"
  end

  create_table "size_widths", force: :cascade do |t|
    t.string "width"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name_en"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name_fr"
    t.string   "name_es"
    t.string   "slug"
  end

  add_index "sub_categories", ["slug"], name: "index_sub_categories_on_slug", unique: true, using: :btree

  create_table "surfboard_artworks", force: :cascade do |t|
    t.integer "surfboard_details_id"
    t.integer "artworks_id"
  end

  create_table "surfboard_detail_params", force: :cascade do |t|
    t.integer "surfboard_detail_id"
    t.integer "size_height_id"
    t.integer "size_width_id"
    t.integer "thickness_id"
    t.integer "volume_id"
    t.integer "tail_shape_id"
    t.integer "construction_id"
    t.integer "fin_system_id"
    t.integer "artwork_id"
  end

  create_table "surfboard_details", force: :cascade do |t|
    t.integer "product_id"
    t.string  "perfect_for"
    t.string  "perfecto_para"
    t.string  "parfait_pour"
    t.string  "manufacturing_time_en"
    t.string  "manufacturing_time_es"
    t.string  "manufacturing_time_fr"
    t.string  "rocker_en"
    t.string  "rocker_es"
    t.string  "rocker_fr"
    t.string  "rails_en"
    t.string  "rails_es"
    t.string  "rails_fr"
    t.string  "concave_en"
    t.string  "concave_es"
    t.string  "concave_fr"
    t.string  "wave_size_en"
    t.string  "wave_size_es"
    t.string  "wave_size_fr"
  end

  create_table "tail_shapes", force: :cascade do |t|
    t.string  "name"
    t.decimal "price", precision: 10, scale: 2
  end

  create_table "thicknesses", force: :cascade do |t|
    t.string "thickness"
  end

  create_table "user_favourites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favouriteable_id"
    t.string   "favouriteable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "user_favourites", ["favouriteable_type", "favouriteable_id"], name: "favouriteable_polymorphic_index", using: :btree
  add_index "user_favourites", ["user_id"], name: "index_user_favourites_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.integer  "currency_id"
    t.integer  "language_id"
    t.string   "last_name"
    t.date     "dob"
    t.integer  "sex"
    t.boolean  "company"
    t.text     "bio"
    t.string   "locale"
    t.string   "surname"
    t.integer  "country_id"
  end

  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.boolean  "main"
    t.text     "comment"
    t.boolean  "day"
    t.string   "caption"
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "host",        limit: 10
    t.string   "code",        limit: 20
  end

  create_table "volumes", force: :cascade do |t|
    t.string "volume"
  end

  add_foreign_key "companies_countries", "companies"
  add_foreign_key "companies_countries", "countries"
  add_foreign_key "countries", "currencies"
  add_foreign_key "countries", "languages"
  add_foreign_key "countries", "regions"
  add_foreign_key "filter_options", "filters"
  add_foreign_key "filter_options_products", "filter_options"
  add_foreign_key "filter_options_products", "products"
  add_foreign_key "filters", "sub_categories"
  add_foreign_key "region_product_urls", "products"
  add_foreign_key "region_product_urls", "regions"
  add_foreign_key "user_favourites", "users"
end
