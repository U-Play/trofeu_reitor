class CreateFormats < ActiveRecord::Migration
  def change
    create_table :formats do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
