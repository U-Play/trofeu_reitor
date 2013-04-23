class AddNGroupsToGroupStage < ActiveRecord::Migration
  def change
    add_column :group_stages, :n_groups, :integer
  end
end
