class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :group
      t.integer :position
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :deleted_at
      t.references :tournament
      t.references :local
      t.references :winner
      t.references :team_one
      t.references :team_two

      t.timestamps
    end
    add_index :matches, :tournament_id
    add_index :matches, :local_id
    add_index :matches, :winner_id
    add_index :matches, :team_one_id
    add_index :matches, :team_two_id
  end
end
