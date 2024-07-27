class CreateGrouopMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :grouop_messages do |t|
      
      t.integer :customer_id, null: false, foreign_key: true
      t.integer :room_id
      t.string :body
      
      t.timestamps
    end
  end
end
