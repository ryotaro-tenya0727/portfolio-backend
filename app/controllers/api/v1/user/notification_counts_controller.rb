class Api::V1::User::NotificationCountsController < SecuredController
  def index
    render json: { new_notifications_count: current_user.new_notifications_count }, status: :ok
  end
end
