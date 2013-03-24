class CreateKnockoutStages < ActiveRecord::Migration
  def change
    create_table :knockout_stages do |t|
      t.boolean :third_place
      t.boolean :result_homologation
      t.references :tournament
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :knockout_stages, :tournament_id
  end
end
