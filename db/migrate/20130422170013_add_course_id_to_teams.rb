class AddCourseIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :course_id, :integer

    add_index :teams, :course_id
  end
end
