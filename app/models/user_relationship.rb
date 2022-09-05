# == Schema Information
#
# Table name: user_relationships
#
#  id          :bigint           not null, primary key
#  uuid        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  follow_id   :bigint           not null
#  follower_id :bigint           not null
#
# Indexes
#
#  index_user_relationships_on_follow_id                  (follow_id)
#  index_user_relationships_on_follow_id_and_follower_id  (follow_id,follower_id) UNIQUE
#  index_user_relationships_on_follower_id                (follower_id)
#
# Foreign Keys
#
#  fk_rails_...  (follow_id => users.id)
#  fk_rails_...  (follower_id => users.id)
#
class UserRelationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :follow, class_name: 'User'
  validates :follow_id, uniqueness: { scope: :follower_id }
  validates :uuid, uniqueness: true
end
