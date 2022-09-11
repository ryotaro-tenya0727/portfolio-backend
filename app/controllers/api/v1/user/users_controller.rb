class Api::V1::User::UsersController < SecuredController
  def index
    render_json = User::LoginUserSerializer.new(current_user).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def user_info
    render json: current_user, status: :ok
  end

  delegate :destroy, to: :current_user

  def following
    authorize User
    following_users = current_user.following
    render_json = User::UsersSerializer.new(following_users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end

  def followers
    authorize User
    followers = current_user.followers
    render_json = User::UsersSerializer.new(followers, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end
end
