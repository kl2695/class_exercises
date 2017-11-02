class Dropcolumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :author_id, :string
    remove_column :comments, :post_id, :string
  end
end
