class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :dish, null: false, index: true
      t.text :impression, null: false
      t.string :restaurant_name, null: false
      t.string :menu, null: false
      t.string :address, null: false
      
      t.timestamps
    end
  end
end
