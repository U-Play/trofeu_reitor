class CreateHighlightOccurrences < ActiveRecord::Migration
  def change
    create_table :highlight_occurrences do |t|
      t.integer :total
      t.integer :time
      t.datetime :deleted_at
      t.references :highlight
      t.references :match
      t.references :athlete

      t.timestamps
    end
    add_index :highlight_occurrences, :highlight_id
    add_index :highlight_occurrences, :match_id
    add_index :highlight_occurrences, :athlete_id
  end
end
