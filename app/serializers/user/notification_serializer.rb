class User::NotificationSerializer
  include JSONAPI::Serializer
  attributes :action, :checked

  attribute :notifier_name do |notification|
    notification.notifier.name
  end

  attribute :notifier_image do |notification|
    notification.notifier.user_image
  end

  attribute :created_at do |notification|
    notification.created_at.strftime("%Y年%m月%d日")
  end

  attribute :diary_event_name, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.event_name
  end

  attribute :recommended_member_name, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.recommended_member.nickname
  end

  def self.notification_diary_exists?(notification)
    notification.diary.present?
  end
end
