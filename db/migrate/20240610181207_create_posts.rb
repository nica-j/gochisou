class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id, null: false
      t.integer :restaurant_id, null: false
      t.integer :genre_id, null: false
      t.string :dish, null: false, index: true
      t.text :impression, null: false
      
      t.timestamps
    end
  end
end
