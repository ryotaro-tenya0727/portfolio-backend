class User < ApplicationRecord
  has_many :recommended_members, dependent: :destroy

  enum role: { general: 0, admin: 1 }

  validates :uuid, uniqueness: true
  validates :sub, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :role, presence: true

  def self.from_token_payload(payload, name)
    find_by(sub: payload['sub']) || create!(sub: payload['sub'], name: name)
  end
end
