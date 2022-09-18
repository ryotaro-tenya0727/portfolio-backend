class User::UserPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def following?
    check_current_user
  end

  def followers?
    check_current_user
  end
end
