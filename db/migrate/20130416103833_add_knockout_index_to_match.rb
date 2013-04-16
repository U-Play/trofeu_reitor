class AddKnockoutIndexToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :knockout_index, :integer
  end
end
