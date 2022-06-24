class DiaryListSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :impressive_memory

  attribute :diary_user do |object|
    object.user.name.to_s
  end

  attribute :diary_user_image do |object|
    object.user.user_image
  end

  attribute :diary_member_nickname do |object|
    object.recommended_member.nickname.to_s
  end

  attribute :diary_member_group do |object|
    object.recommended_member.group.to_s
  end

  attribute :diary_image do |object|
    object.diary_images.pick(:diary_image_url)
  end
end
