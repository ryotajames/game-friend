class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      # t.references :subject, polymorphic: true
      t.references :customer, foreign_key: true
      t.integer :subject_id
      t.integer :subject_type
      t.integer :favorite_id
      t.integer :comment_id
      t.integer :group_id
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :action_type, null: false
      t.integer :post_id
      t.boolean :checked
      t.timestamps
    end
  end
end
