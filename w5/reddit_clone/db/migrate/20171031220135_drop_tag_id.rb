class DropTagId < ActiveRecord::Migration[5.1]
  def change
    remove_column :taggings, :tag_id, :integer
  end
end
