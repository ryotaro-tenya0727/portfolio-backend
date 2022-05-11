class AddUserIdToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_reference :diaries, :user, foreign_key: true, null: false
  end
end
