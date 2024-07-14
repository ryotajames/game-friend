class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :group_name, null: false
      t.string :beginning, null: false
      t.string :main_game, null: false
      t.string :image_id
      t.integer :owner_id
      t.timestamps
    end
  end
end
