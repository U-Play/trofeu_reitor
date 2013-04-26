class AddAthletesPerTeamToSports < ActiveRecord::Migration
  def change
    add_column :sports, :athletes_per_team, :integer
  end
end
