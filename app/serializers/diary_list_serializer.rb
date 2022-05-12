class DiaryListSerializer
  include JSONAPI::Serializer
  attributes :uuid, :event_name, :event_date, :event_venue, :event_polaroid_count

  attribute :diary_member_nickname do |object|
    object.recommended_member.nickname.to_s
  end
end
