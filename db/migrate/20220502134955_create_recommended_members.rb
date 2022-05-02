class CreateRecommendedMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :recommended_members do |t|
      t.string :uuid, null: false
      t.references :user, foreign_key: true, null: false
      t.string :nickname, null: false
      t.string :group
      t.date :first_met_date

      t.timestamps
    end
    add_index :recommended_members, :uuid, unique: true
  end
end
