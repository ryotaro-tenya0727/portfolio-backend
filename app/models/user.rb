# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  me_introduction :text(65535)
#  name            :string(255)      not null
#  role            :integer          default("general"), not null
#  sub             :string(255)      not null
#  user_image      :text(65535)
#  uuid            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_created_at  (created_at)
#  index_users_on_sub         (sub) UNIQUE
#  index_users_on_uuid        (uuid) UNIQUE
#
require 'faraday'
require 'faraday/net_http'
require 'erb'
include ERB::Util

Faraday.default_adapter = :net_http

class User < ApplicationRecord
  has_many :recommended_members, dependent: :destroy
  has_many :diaries, dependent: :destroy

  # フォロー機能
  has_many :active_relationships, class_name: 'UserRelationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :follow
  has_many :passive_relationships, class_name: 'UserRelationship',
                                   foreign_key: 'follow_id',
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  # いいね機能
  has_many :likes
  has_many :like_diaries, through: :likes, source: :diary
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'notifier_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'notified_id', dependent: :destroy

  enum role: { general: 0, admin: 1 }

  validates :sub, presence: true, uniqueness: true
  validates :role, presence: true

  scope :name_contain, ->(name) { where('name LIKE (?)', "%#{name}%") }

  # いいね
  def like(diary)
    like_diaries << diary
  end

  def unlike(diary)
    likes.find_by(diary_id: diary.id).destroy
  end

  def like?(diary)
    diary.like_users.include?(self)
  end

  # フォロー
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(follow_id: other_user.id).destroy
  end

  def following?(other_user)
    other_user.followers.include?(self)
  end

  # 通知
  ## 新しい通知の数
  def new_notifications_count
    notifications_count = Notification.where('notified_id = (:notified_id)', notified_id: id).pluck(:checked).tally[false]
    !notifications_count.nil? ? notifications_count : 0
  end

  def create_like_diary_notification(notified_user, diary)
    notified_user_id = notified_user.id
    diary_id = diary.id
    notification = Notification.where(['notifier_id = ? and notified_id = ? and diary_id = ? and action = ? ', id, notified_user_id, diary_id, 'like'])
    if notification.blank?
      notification = active_notifications.new(
        notified_id: notified_user_id,
        diary_id: diary_id,
        action: 'like'
      )
      notification.save if notification.valid?
    end
  end

  ## フォロー通知
  def create_follow_notification(notified_user)
    notified_user_id = notified_user.id
    notification = active_notifications.new(
      notified_id: notified_user_id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

  # タイムライン
  def time_line(page)
    following_ids = 'SELECT follow_id FROM user_relationships WHERE follower_id = :user_id'
    Diary.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
         .page(page)
         .without_count
         .preload(:diary_images, :recommended_member, :user, :like_users)
  end

  # 現在のユーザーを取得
  def self.current_user_from_token_payload(payload)
    find_by(sub: payload['sub'])
  end

  # ユーザーを作成
  def self.create_user_from_token_payload(payload, name, image)
    user = find_or_initialize_by(sub: payload['sub'], name: name, user_image: image)
    user.save!
    user
    # if user
    #   me_introduction = get_auth0_me_introduction(payload['sub'])
    #   user.update(name: name)
    #   user
    # else
    #   ActiveRecord::Base.transaction do
    #     create_user(payload['sub'], name)
    #   end
    # end
    # create!(name: name)
  end

  def self.create_user(sub, name, user_image)
    me_introduction = get_auth0_me_introduction(sub)
    create!(sub: sub, name: name, user_image: user_image, me_introduction: me_introduction)
  end

  def self.get_user_information(sub)
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
    connection.get("#{ENV['AUTH0_DOMEIN']}/api/v2/users/#{user_id}") do |request|
      request.headers['Authorization'] = "Bearer #{token}"
    end
  end

  def self.get_auth0_me_introduction(sub)
    response_for_user = get_user_information(sub)
    JSON.parse(response_for_user.body)['description']
  end
end
