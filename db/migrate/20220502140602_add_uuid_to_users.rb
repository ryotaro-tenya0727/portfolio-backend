class AddUuidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uuid, :string, null: false
    add_index :users, :uuid, unique: true
  end
end
