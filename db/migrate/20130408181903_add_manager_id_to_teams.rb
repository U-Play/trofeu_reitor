class AddManagerIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :manager_id, :integer
    add_index  :teams, :manager_id
  end
end
