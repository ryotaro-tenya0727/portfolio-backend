class Api::V1::User::UserRelationshipsController < SecuredController
  def index
    users = if current_user.nil?
              User.all
                  .page(params[:page])
                  .without_count
                  .preload(:followers, :recommended_members, :diaries)
                  .order(created_at: 'DESC')
            else
              User.all
                  .page(params[:page])
                  .without_count
                  .preload(:followers, :recommended_members, :diaries)
                  .order(created_at: 'DESC')
            end
    render_json = User::UsersSerializer.new(users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end

  def create
    authorize([:user, UserRelationship])
    ActiveRecord::Base.transaction do
      other_user = User.find_by(id: params[:id])
      current_user.follow(other_user)
    end
    head :ok
  end

  def destroy
    authorize([:user, UserRelationship])
    ActiveRecord::Base.transaction do
      other_user = User.find_by(id: params[:id])
      current_user.unfollow(other_user)
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
