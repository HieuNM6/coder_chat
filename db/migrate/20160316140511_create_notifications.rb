class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :read, default: false
      t.references :event, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
