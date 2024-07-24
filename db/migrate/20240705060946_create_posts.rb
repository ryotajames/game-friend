class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :post_introduction, null: false
      t.integer :game_id
      # t.integer :customer_id
      t.timestamps
    end
  end
end
