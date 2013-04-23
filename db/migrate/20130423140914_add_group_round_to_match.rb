class AddGroupRoundToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :group_round, :integer
  end
end
