class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at
      t.references :user

      t.timestamps
    end
    add_index :events, :user_id
  end
end
