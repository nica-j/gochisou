class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|

      t.integer :post_id, null: false
      t.string :name, null: false
      t.string :menu, null: false
      t.string :address, null: false
      
      t.timestamps
    end
  end
end
