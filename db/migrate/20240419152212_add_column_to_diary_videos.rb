class AddColumnToDiaryVideos < ActiveRecord::Migration[6.1]
  def up
    add_column :diary_videos, :uuid, :string, null: false
  end

  def down
    remove_column :diary_videos, :uuid
  end
end
