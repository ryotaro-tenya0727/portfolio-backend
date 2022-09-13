class AddIndexToUsersAndDiaries < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :created_at
    add_index :diaries, :created_at
  end
end
