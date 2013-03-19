class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|
      t.string :city
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
