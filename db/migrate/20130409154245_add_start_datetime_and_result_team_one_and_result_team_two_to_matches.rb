class AddStartDatetimeAndResultTeamOneAndResultTeamTwoToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :start_datetime, :datetime
    add_column :matches, :result_team_one, :string
    add_column :matches, :result_team_two, :string
    add_column :matches, :started, :boolean
    add_column :matches, :ended, :boolean
  end
end
