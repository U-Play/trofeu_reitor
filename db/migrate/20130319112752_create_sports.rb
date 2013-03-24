class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
