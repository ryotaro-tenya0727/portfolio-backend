class CreateRelation < ActiveRecord::Migration[6.1]
  def change
    create_table :user_relationships do |t|
      t.references :follow, foreign_key: { to_table: :users }, null: false
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
    add_index :user_relationships, [:follow_id, :follower_id], unique: true
  end
end
