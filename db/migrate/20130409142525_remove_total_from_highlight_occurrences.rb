class RemoveTotalFromHighlightOccurrences < ActiveRecord::Migration
  def up
    remove_column :highlight_occurrences, :total
  end

  def down
    add_column :highlight_occurrences, :total, :integer
  end
end
