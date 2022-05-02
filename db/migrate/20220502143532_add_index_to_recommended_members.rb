class AddIndexToRecommendedMembers < ActiveRecord::Migration[6.1]
  def change
    add_index :recommended_members, [:user_id, :created_at]
  end
end
