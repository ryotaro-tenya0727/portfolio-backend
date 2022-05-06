class Api::V1::UsersController < SecuredController
  skip_before_action :authorize_request, only: [:create]

  def create
    register_user
    render json: { "register_user": true }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def register_user
    authorization = Authorization::AuthorizationService.new(request.headers)
    user_name = user_params[:name]
    @current_user = authorization.current_user(user_name)
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end
