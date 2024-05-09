class AddDiaryVideosTable < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_videos do |t|
      t.references :diary,  index: true, foreign_key: true
      t.string :video_uid, null: false
      t.string :thumbnail_url, null: false
      t.timestamps
    end
  end
end
