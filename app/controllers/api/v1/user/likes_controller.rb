class Api::V1::User::LikesController < SecuredController
  def create
    authorize([:user, Like])
    ActiveRecord::Base.transaction do
      diary = Diary.find(params[:id])
      notified_user = diary.user
      current_user.like(diary)
      current_user.create_like_diary_notification(notified_user, diary)
      Websocket::Notification::MypageNewNotificationCountPusher.new(notified_user).notify
    end
    head :ok
  end

  def destroy
    authorize([:user, Like])
    ActiveRecord::Base.transaction do
      diary = Diary.find(params[:id])
      current_user.unlike(diary)
    end
    head :ok
  end
end
