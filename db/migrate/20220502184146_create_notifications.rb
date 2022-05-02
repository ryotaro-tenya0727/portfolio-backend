class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :uuid, null: false
      t.references :notifier, foreign_key: { to_table: :users }, null: false
      t.references :notified, foreign_key: { to_table: :users }, null: false
      t.references :diary, foreign_key: true
      t.references :comment, foreign_key: true
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :uuid, unique: true
  end
end
