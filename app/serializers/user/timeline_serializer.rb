class User::TimelineSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :impressive_memory, :event_name, :event_date, :event_venue, :event_polaroid_count

  attribute :diary_user_name do |object|
    object.user.name.to_s
  end

  attribute :diary_user_image do |object|
    object.user.user_image
  end

  attribute :diary_member_nickname do |object|
    object.recommended_member.nickname.to_s
  end

  attribute :diary_image do |object|
    object.diary_images.pick(:diary_image_url)
  end
end
