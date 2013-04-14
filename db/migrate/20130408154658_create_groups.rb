class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :tournament
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :groups, :tournament_id
  end
end
