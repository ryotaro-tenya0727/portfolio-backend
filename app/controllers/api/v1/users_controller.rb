class Api::V1::UsersController < SecuredController
  skip_before_action :authorize_request, only: [:create]

  def create
    register_user
    render json: current_user, status: :ok
  end

  def user_info
    render json: current_user, status: :ok
  end

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

  delegate :destroy, to: :current_user

  private

  def user_params
    params.require(:user).permit(:name, :user_image)
  end

  def register_user
    authorization = Authorization::AuthorizationService.new(request.headers)
    user_name = user_params[:name]
    user_image = user_params[:user_image]
    @current_user = authorization.current_user(user_name, user_image)
  end
end
