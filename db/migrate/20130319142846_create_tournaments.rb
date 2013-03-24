class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.text :rules
      t.string :contacts
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :deleted_at
      t.references :sport
      t.references :format
      t.references :event

      t.timestamps
    end
    add_index :tournaments, :sport_id
    add_index :tournaments, :format_id
    add_index :tournaments, :event_id
  end
end
