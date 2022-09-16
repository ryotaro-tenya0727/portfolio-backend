# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  uuid       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diary_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_diary_id              (diary_id)
#  index_likes_on_user_id               (user_id)
#  index_likes_on_user_id_and_diary_id  (user_id,diary_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (diary_id => diaries.id)
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :diary
  validates :user_id, uniqueness: { scope: :diary_id }
end
