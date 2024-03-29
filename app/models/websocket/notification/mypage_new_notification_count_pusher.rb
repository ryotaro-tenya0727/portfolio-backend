module Websocket
  module Notification
    class MypageNewNotificationCountPusher
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def notify
        AppPusher.trigger("private-notification-user-#{user.id}-channel", 'new-notification-event', {
                            new_notifications_count: user.new_notifications_count
                          })
      end
    end
  end
end
