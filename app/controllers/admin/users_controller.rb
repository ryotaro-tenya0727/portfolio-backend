class Admin::UsersController < ApplicationController
  def index
    @users = policy_scope(User, policy_scope_class: Admin::UserPolicy)
  end

  def destroy
  end
end
