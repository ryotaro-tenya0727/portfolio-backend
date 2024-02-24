class Api::V1::User::UserRelationshipsController < SecuredController
  def index
    users = User.all
                .page(params[:page])
                .without_count
                .preload(:followers, :recommended_members, :diaries)
                .order(created_at: 'DESC')
    render_json = User::UsersSerializer.new(users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end

  def create
    authorize([:user, UserRelationship])
    followed_user = User.find_by(id: params[:id])
    ActiveRecord::Base.transaction do
      current_user.follow(followed_user)
      current_user.create_follow_notification(followed_user)
    end
    Websocket::Notification::MypageNewNotificationCountPusher.new(followed_user).notify
    head :ok
  end

  def destroy
    authorize([:user, UserRelationship])
    ActiveRecord::Base.transaction do
      followed_user = User.find_by(id: params[:id])
      current_user.unfollow(followed_user)
    end
    head :ok
  end

  def search
    users = SearchUsersForm.new(search_params)
                           .search(params[:page])
                           .preload(:followers, :recommended_members, :diaries)
                           .order(created_at: 'DESC')
    render_json = User::UsersSerializer.new(users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end

  private

  def search_params
    params.require(:search).permit(:name)
  end
end
