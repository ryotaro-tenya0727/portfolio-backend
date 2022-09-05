class AddColumnToRelations < ActiveRecord::Migration[6.1]
  def change
    add_column :user_relationships, :uuid, :string, null: false
  end
end
