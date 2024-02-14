class Api::V1::User::UsersController < SecuredController
  def index
    render_json = User::LoginUserSerializer.new(current_user).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def user_info
    render json: { user_id: current_user.id, name: current_user.name, new_notifications_count: current_user.new_notifications_count }, status: :ok
  end

  delegate :destroy, to: :current_user

  def following
    authorize([:user, User])
    following_users = current_user.following
    render_json = User::UsersSerializer.new(following_users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end

  def followers
    authorize([:user, User])
    followers = current_user.followers
    render_json = User::UsersSerializer.new(followers, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end
end
