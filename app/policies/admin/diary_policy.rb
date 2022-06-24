class Admin::DiaryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.published
      end
    end
  end
end
