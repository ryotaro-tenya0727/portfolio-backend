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
    notification.created_at.strftime('%Y年%m月%d日')
  end

  attribute :diary_id, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.id
  end

  attribute :diary_event_name, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.event_name
  end

  attribute :recommended_member_id, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.recommended_member.id
  end

  attribute :recommended_member_uuid, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.recommended_member.uuid
  end

  attribute :recommended_member_name, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.recommended_member.nickname
  end

  attribute :recommended_member_group, if: proc { |notification|
    notification_diary_exists?(notification)
  } do |notification|
    notification.diary.recommended_member.group
  end

  def self.notification_diary_exists?(notification)
    notification.diary.present?
  end
end
