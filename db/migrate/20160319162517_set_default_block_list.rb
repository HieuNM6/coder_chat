class SetDefaultBlockList < ActiveRecord::Migration
  def change
    change_column :users, :block_list, :string, default: ""
  end
end
