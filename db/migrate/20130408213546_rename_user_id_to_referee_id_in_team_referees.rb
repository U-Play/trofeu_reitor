class RenameUserIdToRefereeIdInTeamReferees < ActiveRecord::Migration
  change_table :team_referees do |t|
    t.rename :user_id, :referee_id
  end
end
