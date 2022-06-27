class DiaryDetailSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :event_name, :event_date, :event_venue, :event_polaroid_count, :impressive_memory, :impressive_memory_detail

  attribute :diary_user do |object|
    object.user.name.to_s
  end

  attribute :diary_member_nickname do |object|
    object.recommended_member.nickname.to_s
  end

  attribute :diary_member_group do |object|
    object.recommended_member.group.to_s
  end

  attribute :diary_images do |object|
    object.diary_images.pluck(:diary_image_url)
  end
end
