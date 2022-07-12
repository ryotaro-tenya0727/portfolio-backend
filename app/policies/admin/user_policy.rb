class Admin::UserPolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError unless user

    super
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user.admin?

      scope.all
    end
  end
end
