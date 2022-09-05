# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  uuid       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diary_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_diary_id  (diary_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (diary_id => diaries.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  validates :uuid, uniqueness: true
end
