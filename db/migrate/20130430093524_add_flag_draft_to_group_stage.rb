class AddFlagDraftToGroupStage < ActiveRecord::Migration
  def change
    add_column :group_stages, :draft_made, :boolean, :null => false, :default => false
  end
end
