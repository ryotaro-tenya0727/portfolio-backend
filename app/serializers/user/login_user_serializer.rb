class User::LoginUserSerializer
  include JSONAPI::Serializer
  attributes :name, :me_introduction, :user_image

  attribute :recommended_members_count do |object|
    object.recommended_members.count
  end

  attribute :diaries_count do |object|
    object.diaries.count
  end

  attribute :total_polaroid_count do |object|
    object.diaries.pluck(:event_polaroid_count).sum
  end
end
