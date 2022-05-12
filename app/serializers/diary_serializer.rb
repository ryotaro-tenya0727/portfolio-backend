class DiarySerializer
  include JSONAPI::Serializer
  # 画像のURLも必要
  attributes :uuid, :event_name, :event_date, :event_venue, :event_polaroid_count, :impressive_memory, :impressive_memory_detail

  attribute :diary_user do |object|
    object.user.name.to_s
  end

  attribute :diary_member_nickname do |object|
    object.recommended_member.nickname.to_s
  end

    attribute :diary_member_group do |object|
    object.recommended_member.group.to_s
  end
end
