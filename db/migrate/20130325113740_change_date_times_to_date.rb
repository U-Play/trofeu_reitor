class ChangeDateTimesToDate < ActiveRecord::Migration
  def change
    change_column :tournaments, :start_date, :date
    change_column :tournaments, :end_date, :date

    change_column :events, :start_date, :date
    change_column :events, :end_date, :date
  end
end
