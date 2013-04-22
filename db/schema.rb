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

ActiveRecord::Schema.define(:version => 20130422170013) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "formats", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "deleted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "group_stages", :force => true do |t|
    t.integer  "n_rounds"
    t.integer  "win_points"
    t.integer  "tie_points"
    t.integer  "loss_points"
    t.integer  "tournament_id"
    t.datetime "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "group_stages", ["tournament_id"], :name => "index_group_stages_on_tournament_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "tournament_id"
    t.datetime "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "groups", ["tournament_id"], :name => "index_groups_on_tournament_id"

  create_table "highlight_occurrences", :force => true do |t|
    t.integer  "time"
    t.datetime "deleted_at"
    t.integer  "highlight_id"
    t.integer  "match_id"
    t.integer  "athlete_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "highlight_occurrences", ["athlete_id"], :name => "index_highlight_occurrences_on_athlete_id"
  add_index "highlight_occurrences", ["highlight_id"], :name => "index_highlight_occurrences_on_highlight_id"
  add_index "highlight_occurrences", ["match_id"], :name => "index_highlight_occurrences_on_match_id"

  create_table "highlights", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "deleted_at"
    t.integer  "sport_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "highlights", ["sport_id"], :name => "index_highlights_on_sport_id"

  create_table "knockout_stages", :force => true do |t|
    t.boolean  "third_place"
    t.boolean  "result_homologation"
    t.integer  "tournament_id"
    t.datetime "deleted_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "knockout_stages", ["tournament_id"], :name => "index_knockout_stages_on_tournament_id"

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "match_athletes", :force => true do |t|
    t.boolean  "starter"
    t.boolean  "substitute"
    t.boolean  "captain"
    t.integer  "number"
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "athlete_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "match_athletes", ["athlete_id"], :name => "index_match_athletes_on_athlete_id"
  add_index "match_athletes", ["match_id"], :name => "index_match_athletes_on_match_id"
  add_index "match_athletes", ["team_id"], :name => "index_match_athletes_on_team_id"

  create_table "match_referees", :force => true do |t|
    t.datetime "deleted_at"
    t.integer  "match_id"
    t.integer  "referee_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "match_referees", ["match_id"], :name => "index_match_referees_on_match_id"
  add_index "match_referees", ["referee_id"], :name => "index_match_referees_on_referee_id"

  create_table "matches", :force => true do |t|
    t.integer  "position"
    t.datetime "start_datetime"
    t.datetime "deleted_at"
    t.integer  "tournament_id"
    t.integer  "location_id"
    t.integer  "winner_id"
    t.integer  "team_one_id"
    t.integer  "team_two_id"
    t.integer  "format_id"
    t.boolean  "started"
    t.boolean  "ended"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "knockout_index"
  end

  add_index "matches", ["format_id"], :name => "index_matches_on_format_id"
  add_index "matches", ["location_id"], :name => "index_matches_on_location_id"
  add_index "matches", ["team_one_id"], :name => "index_matches_on_team_one_id"
  add_index "matches", ["team_two_id"], :name => "index_matches_on_team_two_id"
  add_index "matches", ["tournament_id"], :name => "index_matches_on_tournament_id"
  add_index "matches", ["winner_id"], :name => "index_matches_on_winner_id"

  create_table "news", :force => true do |t|
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news_references", :force => true do |t|
    t.integer  "news_id"
    t.integer  "newsable_id"
    t.string   "newsable_type"
    t.datetime "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "news_references", ["news_id"], :name => "index_news_references_on_news_id"
  add_index "news_references", ["newsable_id"], :name => "index_news_references_on_newsable_id"

  create_table "penalties", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "athlete_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "penalties", ["athlete_id"], :name => "index_penalties_on_athlete_id"
  add_index "penalties", ["match_id"], :name => "index_penalties_on_match_id"
  add_index "penalties", ["team_id"], :name => "index_penalties_on_team_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "desc"
    t.datetime "deleted_at"
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "team_athletes", :force => true do |t|
    t.datetime "deleted_at"
    t.integer  "team_id"
    t.integer  "athlete_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "team_athletes", ["athlete_id"], :name => "index_team_athletes_on_user_id"
  add_index "team_athletes", ["team_id"], :name => "index_team_athletes_on_team_id"

  create_table "team_data", :force => true do |t|
    t.string   "color"
    t.string   "result"
    t.datetime "deleted_at"
    t.integer  "match_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "team_data", ["match_id"], :name => "index_team_data_on_match_id"
  add_index "team_data", ["team_id"], :name => "index_team_data_on_team_id"

  create_table "team_referees", :force => true do |t|
    t.datetime "deleted_at"
    t.integer  "team_id"
    t.integer  "referee_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "team_referees", ["referee_id"], :name => "index_team_referees_on_user_id"
  add_index "team_referees", ["team_id"], :name => "index_team_referees_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.integer  "tournament_id"
    t.integer  "manager_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "group_id"
    t.integer  "course_id"
  end

  add_index "teams", ["course_id"], :name => "index_teams_on_course_id"
  add_index "teams", ["manager_id"], :name => "index_teams_on_coach_id"
  add_index "teams", ["tournament_id"], :name => "index_teams_on_tournament_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "rules"
    t.string   "contacts"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "deleted_at"
    t.integer  "sport_id"
    t.integer  "format_id"
    t.integer  "event_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "number_of_teams"
  end

  add_index "tournaments", ["event_id"], :name => "index_tournaments_on_event_id"
  add_index "tournaments", ["format_id"], :name => "index_tournaments_on_format_id"
  add_index "tournaments", ["sport_id"], :name => "index_tournaments_on_sport_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "student_number"
    t.string   "sports_number"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "role_id"
    t.datetime "deleted_at"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "validation_state"
    t.integer  "course_id"
  end

  add_index "users", ["course_id"], :name => "index_users_on_course_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
