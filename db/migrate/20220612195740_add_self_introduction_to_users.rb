class AddSelfIntroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :me_introduction, :text
  end
end
