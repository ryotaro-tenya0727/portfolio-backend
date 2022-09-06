class Admin::AdminUserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :sub, :user_image

  attribute :total_polaroid_count do |object|
    object.diaries.pluck(:event_polaroid_count).sum
  end

  attributes :diaries_count do |object|
    object.diaries.size
  end
end
