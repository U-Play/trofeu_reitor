class CreateTeamAthletes < ActiveRecord::Migration
  def change
    create_table :team_athletes do |t|
      t.datetime :deleted_at
      t.references :team
      t.references :user

      t.timestamps
    end
    add_index :team_athletes, :team_id
    add_index :team_athletes, :user_id
  end
end
