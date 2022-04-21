class Api::V1::UsersController < SecuredController
  def create
    render json: { "status": '200' }, status: :ok
  end
end
