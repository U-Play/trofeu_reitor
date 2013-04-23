class AddAthleteState < ActiveRecord::Migration
  def change
    add_column :users, :validation_state, :string
  end
end
