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

  def show?
    own?
  end

  def update?
    own?
  end

  def edit?
    own?
  end

  def destroy?
    own?
  end
end
