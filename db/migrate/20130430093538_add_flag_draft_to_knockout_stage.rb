class AddFlagDraftToKnockoutStage < ActiveRecord::Migration
  def change
    add_column :knockout_stages, :draft_made, :boolean, :null => false, :default => false
  end
end
