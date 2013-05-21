class AddGroupIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :group_id, :integer
    add_index :matches, :group_id
  end
end
