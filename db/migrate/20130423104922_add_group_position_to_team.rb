class AddGroupPositionToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :group_position, :string
  end
end
