class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer     :position
      t.datetime    :start_datetime
      t.datetime    :deleted_at
      t.references  :tournament
      t.references  :location
      t.references  :winner
      t.references  :team_one
      t.references  :team_two
      t.references  :format
      t.string      :result_team_one
      t.string      :result_team_two
      t.string      :color_team_one
      t.string      :color_team_two
      t.boolean     :started
      t.boolean     :ended

      t.timestamps
    end
    add_index :matches, :tournament_id
    add_index :matches, :location_id
    add_index :matches, :winner_id
    add_index :matches, :team_one_id
    add_index :matches, :team_two_id
    add_index :matches, :format_id
  end
end
