class User::UsersSerializer
  include JSONAPI::Serializer
  attributes :name, :me_introduction, :user_image

  def initialize(resource, options = {})
    @@options = options
    super(resource)
  end

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

  attribute :following do |user|
    current_user = @@options[:current_user]
    if current_user.nil?
      'Not Loggin'
    else
      current_user.following?(user)
    end
  end
end
