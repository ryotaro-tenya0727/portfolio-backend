class User::LikePolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def create?
    check_current_user
  end

  def destroy?
    check_current_user
  end
end
