class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at
      t.references :sport

      t.timestamps
    end
    add_index :highlights, :sport_id
  end
end
