class User::ProfilePolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def show?
    check_current_user
  end

  def update?
    check_current_user
  end
end
