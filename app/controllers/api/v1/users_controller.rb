class Api::V1::UsersController < SecuredController
  skip_before_action :authorize_request, only: [:create]

  def index
    render_json = User::LoginUserSerializer.new(current_user)
    render json: render_json, status: :ok
  end

  def create
    register_user
    render json: current_user, status: :ok
  end

  def user_info
    render json: current_user, status: :ok
  end

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
