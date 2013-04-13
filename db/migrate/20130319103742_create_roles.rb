class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.string :desc
    end

    change_table :users do |t|
      t.references :role
    end
  end
end
