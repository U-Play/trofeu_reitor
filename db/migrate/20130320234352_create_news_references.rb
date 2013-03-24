class CreateNewsReferences < ActiveRecord::Migration
  def change
    create_table :news_references do |t|
      t.references :news
      t.references :newsable, polymorphic: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :news_references, :newsable_id
    add_index :news_references, :news_id
  end
end
