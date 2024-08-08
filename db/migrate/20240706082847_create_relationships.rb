class CreateRelationships < ActiveRecord::Migration[6.1]

  def change
    create_table :relationships do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.index [:customer_id, :follow_id], unique: true

      t.timestamps
    end
  end
end
