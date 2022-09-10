class Api::V1::User::UsersController < SecuredController
  def index
    render_json = User::LoginUserSerializer.new(current_user).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
