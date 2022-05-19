class RecommendedMember < ApplicationRecord
  belongs_to :user

  has_many :diaries, dependent: :destroy

  validates :uuid, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :group, length: { maximum: 20 }

  default_scope -> { order(created_at: :desc) }
end
