class AddBlockListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :block_list, :string
  end
end
