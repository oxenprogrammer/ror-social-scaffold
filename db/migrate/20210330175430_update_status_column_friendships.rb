class UpdateStatusColumnFriendships < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :integer, default: 0, using: 'status::integer'
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
