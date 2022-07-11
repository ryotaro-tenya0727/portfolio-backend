class Admin::UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.admin?
      end
    end
  end
end
