class RemoveStartDateAndEndDateFromMatches < ActiveRecord::Migration
  def up
    remove_column :matches, :start_date
    remove_column :matches, :end_date
  end

  def down
    add_column :matches, :end_date, :datetime
    add_column :matches, :start_date, :datetime
  end
end
