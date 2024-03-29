class SecuredController < ApplicationController
  before_action :authorize_request

  private

  attr_reader :current_user

  def authorize_request
    authorization = Authorization::AuthorizationService.new(request.headers)
    @current_user = authorization.current_user
    if @current_user
      if request.path.include?('user_info') && current_user.user_image.nil?
        current_user.update!(user_image: secured_params[:image])
      end
      @current_user
    else
      @current_user = authorization.create_user(secured_params[:name], secured_params[:image])
    end
  rescue JWT::VerificationError, JWT::DecodeError
    @current_user = nil
  end

  def secured_params
    params.permit(:name, :image)
  end
end
