class CreateTeamData < ActiveRecord::Migration
  def change
    create_table :team_data do |t|
      t.string :color
      t.string :result
      t.datetime :deleted_at
      t.references :match
      t.references :team

      t.timestamps
    end
    add_index :team_data, :match_id
    add_index :team_data, :team_id
  end
end
