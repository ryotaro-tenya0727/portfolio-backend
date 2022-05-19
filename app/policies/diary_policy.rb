class DiaryPolicy < ApplicationPolicy
  def initialize(user, record)
    super
  end

  def index?
    true
  end

  def show?
    true
  end
end
