class RemoveCoachIdFromTeams < ActiveRecord::Migration
  def up
    remove_column :teams, :coach_id
  end

  def down
    add_column :teams, :coach_id, :integer
  end
end
