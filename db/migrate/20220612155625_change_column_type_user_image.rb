class ChangeColumnTypeUserImage < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :user_image, :text
  end
end
