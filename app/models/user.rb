class User < ApplicationRecord
  has_many :recommended_members, dependent: :destroy
  has_many :diaries

  enum role: { general: 0, admin: 1 }

  validates :uuid, uniqueness: true
  validates :sub, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :role, presence: true

  def self.from_token_payload(payload, name, user_image)
    user = find_by(sub: payload['sub'])
    if user
      user
    else
      ActiveRecord::Base.transaction do
        new_user = create!(sub: payload['sub'], name: name, user_image: user_image)
      end
    end
  end
end
