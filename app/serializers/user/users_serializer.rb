class User::UsersSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :me_introduction, :user_image

  def initialize(resource, options = {})
    @@current_user = options[:current_user]
    super(resource)
  end

  attribute :recommended_members_count do |user|
    user.recommended_members.size
  end

  attribute :diaries_count do |user|
    user.diaries.size
  end

  attribute :total_polaroid_count do |user|
    user.diaries.pluck(:event_polaroid_count).sum
  end

  attribute :following do |user|
    if  @@current_user.nil?
      'Not Loggin'
    else
      @@current_user.following?(user)
    end
  end

  attribute :me do |user|
    if  @@current_user.nil?
      false
    elsif @@current_user.id == user.id
      true
    else
      false
    end
  end
end
