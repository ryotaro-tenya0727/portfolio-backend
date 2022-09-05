class Api::V1::User::UserRelationshipsController < ApplicationController
  def index
    users = User.all.preload(:followers, :recommended_members, :diaries)
    render_json = UsersSerializer.new(users, current_user: current_user).serializable_hash.to_json
    render json: render_json
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
