class User::TimelineSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :impressive_memory, :event_name, :event_date, :event_venue, :event_polaroid_count

  def initialize(resource, options = {})
    @@current_user = options[:current_user]
    super(resource)
  end

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

  attribute :diary_video_thumbnail_url do |object|
    object.diary_video.thumbnail_url if object.diary_video.present?
  end

  attribute :liked do |diary|
    if @@current_user.nil?
      'Not Loggin'
    else
      @@current_user.like?(diary)
    end
  end

  attribute :me do |diary|
    if @@current_user.nil?
      false
    else
      @@current_user.id == diary.user_id
    end
  end
end
