class CreateGroupStages < ActiveRecord::Migration
  def change
    create_table :group_stages do |t|
      t.integer :n_rounds
      t.integer :win_points
      t.integer :tie_points
      t.integer :loss_points
      t.references :tournament
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :group_stages, :tournament_id
  end
end
