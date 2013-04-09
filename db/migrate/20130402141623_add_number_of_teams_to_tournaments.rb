class AddNumberOfTeamsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :number_of_teams, :integer
  end
end
