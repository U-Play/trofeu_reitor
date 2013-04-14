class AddFormatIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :format_id, :integer
    add_index  :matches, :format_id
  end
end
