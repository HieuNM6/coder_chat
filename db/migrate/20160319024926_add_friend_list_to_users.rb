class AddFriendListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friend_list, :string
  end
end
