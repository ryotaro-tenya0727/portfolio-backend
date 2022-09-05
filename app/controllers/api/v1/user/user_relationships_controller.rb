class Api::V1::User::UserRelationshipsController < ApplicationController
  def index
    users = UsersSerializer.new(User.all.preload(:followers,:recommended_members,  :diaries), current_user: current_user)
    render json: users
  end

  def create
    ActiveRecord::Base.transaction do
      other_user = User.find_by(id: params[:id])
      current_user.follow(other_user)
    end
    head :ok
  end

  def destroy
    other_user = User.find_by(id: params[:id])
    current_user.unfollow(other_user)
    head :ok
  end
end
