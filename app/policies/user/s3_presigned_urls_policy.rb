class User::S3PresignedUrlsPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def diary_presigned_url?
    check_current_user
  end
end
