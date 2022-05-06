class RecommendedMember < ApplicationRecord
  belongs_to :user

  validates :uuid, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :group, length: { maximum: 20 }
end
