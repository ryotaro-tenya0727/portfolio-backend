# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end

  # ApplicationPolicyを継承することによって
  # 継承したクラスの中にScopeクラスが存在。
  # 継承したクラスでScope < Scopeとすることで
  # ApplicationPolicyのScopeを継承したScopeが作れる。

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, '継承先でresolveメソッドが定義されていない'
    end

    private

    attr_reader :user, :scope
  end

  private

  def check_current_user
    !!user
  end
end
