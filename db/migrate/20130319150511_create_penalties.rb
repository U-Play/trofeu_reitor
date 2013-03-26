class CreatePenalties < ActiveRecord::Migration
  def change
    create_table :penalties do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :deleted_at
      t.references :match
      t.references :team
      t.references :user

      t.timestamps
    end
    add_index :penalties, :match_id
    add_index :penalties, :team_id
    add_index :penalties, :user_id
  end
end
