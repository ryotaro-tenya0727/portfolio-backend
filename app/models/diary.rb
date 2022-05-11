class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :recommended_member

  validates :uuid, uniqueness: true

  enum role: { public: 0, private: 1 }
end
