class User::External::Aws::S3::PresignedUrl::DiaryVideoPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def create?
    check_current_user
  end
end
