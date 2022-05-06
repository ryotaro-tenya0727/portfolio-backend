class User::RecommendedMemberPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def index?
    check_current_user
  end

  def create?
    check_current_user
  end

  def update?
    check_current_user
  end

  def edit?
    check_current_user
  end

  def destroy?
    check_current_user
  end
end
