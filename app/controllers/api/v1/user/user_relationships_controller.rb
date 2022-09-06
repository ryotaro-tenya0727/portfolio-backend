class Api::V1::User::UserRelationshipsController < SecuredController
  def index
    users = User.all.preload(:followers, :recommended_members, :diaries).order(id: "DESC")
    render_json = User::UsersSerializer.new(users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end

  def create
    ActiveRecord::Base.transaction do
      other_user = User.find_by(id: params[:id])
      current_user.follow(other_user)
    end
    head :ok
  end

  def destroy
    ActiveRecord::Base.transaction do
      other_user = User.find_by(id: params[:id])
      current_user.unfollow(other_user)
    end
    head :ok
  end
end
