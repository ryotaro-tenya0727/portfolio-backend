class SecuredController < ApplicationController
  before_action :authorize_request

  private

  attr_reader :current_user

  def authorize_request
    authorization = Authorization::AuthorizationService.new(request.headers)
    @current_user = authorization.current_user
    @current_user || @current_user = authorization.create_user(secured_params[:name], secured_params[:image])
  rescue JWT::VerificationError, JWT::DecodeError
    @current_user = nil
  end

  def secured_params
    params.permit(:name, :image)
  end
end
