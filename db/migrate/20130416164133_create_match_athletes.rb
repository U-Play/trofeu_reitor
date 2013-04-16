class CreateMatchAthletes < ActiveRecord::Migration
  def change
    create_table :match_athletes do |t|
      t.boolean :starter
      t.boolean :substitute
      t.boolean :captain
      t.integer :number
      t.references :match
      t.references :team
      t.references :athlete

      t.timestamps
    end
    add_index :match_athletes, :match_id
    add_index :match_athletes, :team_id
    add_index :match_athletes, :athlete_id
  end
end
