class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.string :title
      t.string :description
      t.integer :creator_id

      t.timestamps
    end
  end
end
