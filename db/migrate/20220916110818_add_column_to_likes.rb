class AddColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :uuid, :string, null: false
  end
end
