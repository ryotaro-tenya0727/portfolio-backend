class DropPosts < ActiveRecord::Migration[6.1]
  def change
    drop_table :posts
  end
end
