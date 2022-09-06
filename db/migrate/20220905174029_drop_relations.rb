class DropRelations < ActiveRecord::Migration[6.1]
  def change
    drop_table :user_relationships
  end
end
