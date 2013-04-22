class RemoveCourseFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :course
  end

  def down
    add_column :users, :course, :string
  end
end
