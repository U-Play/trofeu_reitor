class AddUserData < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :course
      t.string :student_number
      t.string :sports_number
    end

    add_attachment :users, :picture
  end
end
