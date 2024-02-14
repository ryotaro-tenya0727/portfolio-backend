class Api::V1::User::PusherAuthController < SecuredController
  def create
    response = AppPusher.authenticate(params[:channel_name], params[:socket_id])
    render json: response
  end
end
