class CreateUserRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :user_relationships do |t|
      t.string :uuid, null: false
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end
    add_index :user_relationships, :follower_id
    add_index :user_relationships, :followed_id
    add_index :user_relationships, [:follower_id, :followed_id], unique: true
    add_index :user_relationships, :uuid, unique: true
  end
end
