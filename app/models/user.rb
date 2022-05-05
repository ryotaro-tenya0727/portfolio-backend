class User < ApplicationRecord
  include CreateUuid
  def self.from_token_payload(payload, name)
    find_by(sub: payload['sub']) || create!(sub: payload['sub'], name: name)
  end
end
