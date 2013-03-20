class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
