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

ActiveRecord::Schema.define(version: 20150409153205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blood_test_assets", force: :cascade do |t|
    t.integer  "blood_test_id"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "blood_test_assets", ["blood_test_id"], name: "index_blood_test_assets_on_blood_test_id", using: :btree

  create_table "blood_test_items", force: :cascade do |t|
    t.integer  "blood_test_id"
    t.string   "name"
    t.decimal  "value"
    t.string   "unit"
    t.string   "test_identifier"
    t.integer  "connected_to_id"
    t.decimal  "min"
    t.decimal  "max"
    t.decimal  "avg"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "category"
  end

  add_index "blood_test_items", ["blood_test_id"], name: "index_blood_test_items_on_blood_test_id", using: :btree

  create_table "blood_tests", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "performed_by"
    t.datetime "taken_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "processing_state"
  end

  add_index "blood_tests", ["patient_id"], name: "index_blood_tests_on_patient_id", using: :btree

  create_table "chart_annotations", force: :cascade do |t|
    t.string   "type"
    t.string   "title"
    t.text     "body"
    t.datetime "period_stats_at"
    t.datetime "pariod_ends_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "patient_metric_id"
    t.string   "status"
    t.integer  "doctor_id"
  end

  add_index "chart_annotations", ["doctor_id"], name: "index_chart_annotations_on_doctor_id", using: :btree
  add_index "chart_annotations", ["patient_metric_id"], name: "index_chart_annotations_on_patient_metric_id", using: :btree

  create_table "conditions", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "name"
    t.date     "started_at"
    t.date     "ended_at"
    t.boolean  "cronic",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "conditions", ["patient_id"], name: "index_conditions_on_patient_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "doctor_patient_relationships", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "pending"
    t.string   "token"
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "title",                     limit: 255
    t.string   "first_name",                limit: 255
    t.string   "last_name",                 limit: 255
    t.string   "middle_name",               limit: 255
    t.integer  "istitution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                     limit: 255, default: "",    null: false
    t.string   "encrypted_password",        limit: 255, default: "",    null: false
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "specialty"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.boolean  "otp_required_for_login"
    t.string   "otp_backup_codes",                                                   array: true
    t.string   "phone_number"
    t.boolean  "guest",                                 default: false
  end

  add_index "doctors", ["email"], name: "index_doctors_on_email", unique: true, using: :btree
  add_index "doctors", ["istitution_id"], name: "index_doctors_on_istitution_id", using: :btree
  add_index "doctors", ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true, using: :btree

  create_table "emergencies", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "description"
    t.string   "status"
    t.integer  "level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "emergencies", ["patient_id"], name: "index_emergencies_on_patient_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.string   "provider",          limit: 255
    t.string   "uid",               limit: 255
    t.text     "token"
    t.integer  "omniauthable_id"
    t.string   "omniauthable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "public_token",      limit: 255
  end

  add_index "identities", ["omniauthable_id", "omniauthable_type"], name: "index_identities_on_omniauthable_id_and_omniauthable_type", using: :btree

  create_table "istitutions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_metrics", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "name"
    t.string   "value"
    t.decimal  "numeric_value"
    t.string   "unit"
    t.datetime "taken_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "hidentifier"
    t.string   "source"
    t.json     "complex_value"
  end

  add_index "patient_metrics", ["hidentifier"], name: "index_patient_metrics_on_hidentifier", using: :btree
  add_index "patient_metrics", ["patient_id"], name: "index_patient_metrics_on_patient_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.string   "title",                     limit: 255
    t.string   "first_name",                limit: 255
    t.string   "last_name",                 limit: 255
    t.string   "middle_name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                     limit: 255, default: "",    null: false
    t.string   "encrypted_password",        limit: 255, default: "",    null: false
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "martial_status"
    t.string   "sex"
    t.date     "birth_date"
    t.string   "profession"
    t.string   "nationality"
    t.string   "ssn"
    t.string   "personal_id_code"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.boolean  "otp_required_for_login"
    t.string   "otp_backup_codes",                                                   array: true
    t.string   "phone_number"
    t.boolean  "guest",                                 default: false
  end

  add_index "patients", ["email"], name: "index_patients_on_email", unique: true, using: :btree
  add_index "patients", ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "blood_test_assets", "blood_tests"
  add_foreign_key "blood_test_items", "blood_tests"
  add_foreign_key "blood_tests", "patients"
  add_foreign_key "chart_annotations", "doctors"
  add_foreign_key "chart_annotations", "patient_metrics"
  add_foreign_key "conditions", "patients"
  add_foreign_key "emergencies", "patients"
  add_foreign_key "patient_metrics", "patients"
end
