class SecuredController < ApplicationController
  before_action :authorize_request

  private

  def authorize_request
    authorization = Authorization::AuthorizationService.new(request.headers)
    user_name = user_params[:name]
    @current_user = authorization.current_user(user_name)
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  attr_reader :current_user

  def user_params
    params.permit(:name)
  end
end
