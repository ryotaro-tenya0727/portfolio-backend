require 'faraday'
require 'faraday/net_http'
require 'erb'

Faraday.default_adapter = :net_http

class User < ApplicationRecord
  include ERB::Util
  has_many :recommended_members, dependent: :destroy
  has_many :diaries

  enum role: { general: 0, admin: 1 }

  validates :uuid, uniqueness: true
  validates :sub, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :role, presence: true

  class << self
    def from_token_payload(payload, name, user_image)
      user = find_by(sub: payload['sub'])
      user || ActiveRecord::Base.transaction do
        create_user(payload['sub'], name, user_image)
      end
    end

    def create_user(sub, name, user_image)
      params = URI.encode_www_form([%w[grant_type client_credentials], ['client_id', ENV['AUTH0_API_CLIENT_ID']],
                                    ['client_secret', ENV['AUTH0_API_CLIENT_SECRET']], ['audience', ENV['AUTH0_AUDIENCE']]])

      connection = Faraday.new(ENV['AUTH0_OAUTH_URL']) do |builder|
        builder.adapter :net_http do |http|
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        builder.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      end

      response_for_token = connection.post(ENV['AUTH0_OAUTH_URL']) do |request|
        request.body = params
      end

      token = JSON.parse(response_for_token.body)['access_token']
      user_id = url_encode(sub)
      response_for_user = connection.get("#{ENV['AUTH0_DOMEIN']}/api/v2/users/#{user_id}") do |request|
        request.headers['Authorization'] = "Bearer #{token}"
      end

      me_introduction = JSON.parse(response_for_user.body)['description']
      create!(sub: sub, name: name, user_image: user_image, me_introduction: me_introduction)
    end
  end
end
