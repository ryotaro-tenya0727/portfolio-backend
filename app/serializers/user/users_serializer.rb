class User::UsersSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :me_introduction, :user_image

  def initialize(resource, options = {})
    @@options = options
    super(resource)
  end

  attribute :recommended_members_count do |object|
    object.recommended_members.count
  end

  attribute :diaries_count do |object|
    object.diaries.count
  end

  attribute :total_polaroid_count do |object|
    object.diaries.pluck(:event_polaroid_count).sum
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
