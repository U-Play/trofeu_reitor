class CreateTeamReferees < ActiveRecord::Migration
  def change
    create_table :team_referees do |t|
      t.datetime :deleted_at
      t.references :team
      t.references :user

      t.timestamps
    end
    add_index :team_referees, :team_id
    add_index :team_referees, :user_id
  end
end
