class RenameCoachToManager < ActiveRecord::Migration
  def change
    rename_column :teams, :coach_id, :manager_id
  end
end
