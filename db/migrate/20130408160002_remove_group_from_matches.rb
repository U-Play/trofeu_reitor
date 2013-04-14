class RemoveGroupFromMatches < ActiveRecord::Migration
  def up
    remove_column :matches, :group
  end

  def down
    add_column :matches, :group, :string
  end
end
