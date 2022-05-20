class SecuredController < ApplicationController
  before_action :authorize_request

  private

  def authorize_request
    authorization = Authorization::AuthorizationService.new(request.headers)
    @current_user = authorization.current_user
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  attr_reader :current_user
end
