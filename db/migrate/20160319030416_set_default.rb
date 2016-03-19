class SetDefault < ActiveRecord::Migration
  def change
    change_column :users, :friend_list, :string, default: ""
  end
end
