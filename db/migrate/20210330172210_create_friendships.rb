class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :requestor_id
      t.integer :requestee_id
      t.string :status

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :requestor_id
    add_foreign_key :friendships, :users, column: :requestee_id
  end
end
