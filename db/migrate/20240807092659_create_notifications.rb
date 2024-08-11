class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :subject, polymorphic: true
      t.references :customer, foreign_key: true
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :action_type, null: false
      t.integer :follower_id
      t.integer :followed_id
      t.integer :post_id
      t.boolean :checked
      t.timestamps
    end
  end
end
