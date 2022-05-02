class AddAndChangeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :sub, false
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :user_image, :string
  end
end
