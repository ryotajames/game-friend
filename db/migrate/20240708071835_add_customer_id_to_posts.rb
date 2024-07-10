class AddCustomerIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :customer, null: false, foreign_key: true
  end
end
