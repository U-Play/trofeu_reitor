class RenameUserIdToAthleteIdInTeamAthletes < ActiveRecord::Migration
  change_table :team_athletes do |t|
    t.rename :user_id, :athlete_id
  end
end
