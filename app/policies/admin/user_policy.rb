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
      if user.admin?
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
