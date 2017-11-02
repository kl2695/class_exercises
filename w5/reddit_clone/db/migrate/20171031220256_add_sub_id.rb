class AddSubId < ActiveRecord::Migration[5.1]
  def change
    add_column :taggings, :sub_id, :integer
  end
end
