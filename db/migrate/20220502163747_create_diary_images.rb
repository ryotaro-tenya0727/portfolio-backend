class CreateDiaryImages < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_images do |t|
      t.string :uuid, null: false
      t.references :diary, foreign_key: true, null: false
      t.string :diary_image_url
      t.timestamps
    end
    add_index :diary_images, :uuid, unique: true
  end
end
