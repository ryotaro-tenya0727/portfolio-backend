# == Schema Information
#
# Table name: recommended_members
#
#  id             :bigint           not null, primary key
#  first_met_date :date
#  group          :string(255)
#  nickname       :string(255)      not null
#  uuid           :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_recommended_members_on_user_id                 (user_id)
#  index_recommended_members_on_user_id_and_created_at  (user_id,created_at)
#  index_recommended_members_on_uuid                    (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class RecommendedMember < ApplicationRecord
  belongs_to :user

  has_many :diaries, dependent: :destroy

  validates :uuid, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :group, length: { maximum: 20 }

  default_scope -> { order(created_at: :desc) }
end
