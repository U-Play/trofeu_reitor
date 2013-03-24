class CreateMatchReferees < ActiveRecord::Migration
  def change
    create_table :match_referees do |t|
      t.datetime :deleted_at
      t.references :match
      t.references :referee

      t.timestamps
    end
    add_index :match_referees, :match_id
    add_index :match_referees, :referee_id
  end
end