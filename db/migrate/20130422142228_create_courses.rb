class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :abbreviation
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
