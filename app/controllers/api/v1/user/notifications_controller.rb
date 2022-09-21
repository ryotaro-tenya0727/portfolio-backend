class Api::V1::User::NotificationsController < SecuredController
  def index
    @notifications = current_user.passive_notifications.preload(:notifier, diary: :recommended_member)
    notificaitons = NotificationSerializer.new(@notifications)
    render json: notificaitons

    @notifications.where(checked: false).update_all(checked: true)
  end
end
