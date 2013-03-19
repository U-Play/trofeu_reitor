class CreateMatchEventOccurrences < ActiveRecord::Migration
  def change
    create_table :match_event_occurrences do |t|
      t.integer :total
      t.string :time
      t.datetime :deleted_at
      t.references :match_event
      t.references :match
      t.references :user

      t.timestamps
    end
    add_index :match_event_occurrences, :match_event_id
    add_index :match_event_occurrences, :match_id
    add_index :match_event_occurrences, :user_id
  end
end
