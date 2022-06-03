class Diary < ApplicationRecord
  has_many :diary_images, dependent: :destroy

  belongs_to :user
  belongs_to :recommended_member

  validates :uuid, uniqueness: true

  enum status: { published: 0, non_published: 1 }

  default_scope -> { order(created_at: :desc) }
end
