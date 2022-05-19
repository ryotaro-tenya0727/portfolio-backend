class User::DiaryListSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :event_name, :event_date, :event_venue, :event_polaroid_count

  attribute :diary_member_nickname do |object|
    object.recommended_member.nickname.to_s
  end

  attribute :diary_images do |object|
    object.diary_images.pluck(:diary_image_url)
  end
end
