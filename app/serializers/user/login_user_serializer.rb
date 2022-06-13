class User::LoginUserSerializer
  include JSONAPI::Serializer
  attributes :name, :me_introduction, :user_image

  attributes :recommended_members_count do |object|
    object.recommended_members.count
  end

  attributes :diaries_count do |object|
    object.diaries.count
  end

  attribute :total_polaroid_count do |object|
    count = 0
    object.diaries.each do |diary|
      count += diary.event_polaroid_count || 0
    end
    count
  end
end
