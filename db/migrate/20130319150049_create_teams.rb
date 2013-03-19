class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.datetime :deleted_at
      t.references :tournament
      t.references :coach

      t.timestamps
    end
    add_index :teams, :tournament_id
    add_index :teams, :coach_id
  end
end
