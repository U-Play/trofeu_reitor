class CreateMatchEvents < ActiveRecord::Migration
  def change
    create_table :match_events do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at
      t.references :sport

      t.timestamps
    end
    add_index :match_events, :sport_id
  end
end
