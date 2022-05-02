class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.string :uuid, null: false
      t.references :recommended_member, foreign_key: true, null: false
      t.string :event_name
      t.date :event_date
      t.string :event_venue
      t.integer :event_polaroid_count
      t.string :impressive_memory
      t.text :impressive_memory_detail
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :diaries, :uuid, unique: true
    add_index :diaries, [:recommended_member_id, :created_at]
  end
end
