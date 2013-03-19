class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.datetime :deleted_at
      t.references :event
      t.references :tournament
      t.references :team
      t.references :match
      t.references :user

      t.timestamps
    end
    add_index :news, :event_id
    add_index :news, :tournament_id
    add_index :news, :team_id
    add_index :news, :match_id
    add_index :news, :user_id
  end
end
