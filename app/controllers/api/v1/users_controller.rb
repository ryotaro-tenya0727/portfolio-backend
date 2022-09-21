class Api::V1::UsersController < SecuredController
  skip_before_action :authorize_request, only: [:create]

  def create
    register_user
    render json: { name: current_user.name, new_notifications_count: current_user.new_notifications_count }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_image)
  end

  def register_user
    authorization = Authorization::AuthorizationService.new(request.headers)
    user_name = user_params[:name]
    user_image = user_params[:user_image]
    @current_user = authorization.create_user(user_name, user_image)
  end
end
