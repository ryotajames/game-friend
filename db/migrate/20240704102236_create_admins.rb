class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :mail, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end
