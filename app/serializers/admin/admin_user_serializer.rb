class Admin::AdminUserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :sub, :user_image

  attribute :total_polaroid_count do |object|
    count = 0
    object.diaries.each do |diary|
      count += diary.event_polaroid_count || 0
    end
    count
  end

  attributes :diaries_count do |object|
    object.diaries.count
  end
end
