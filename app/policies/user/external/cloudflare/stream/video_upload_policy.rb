class User::External::Cloudflare::Stream::VideoUploadPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def create?
    check_current_user
  end
end
