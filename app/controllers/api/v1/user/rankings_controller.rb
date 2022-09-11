class Api::V1::User::RankingsController < SecuredController
  def total_polaroid_count
    users = Ranks::TotalPolaroidCountCreater.create_ranking
    render_json = User::UsersSerializer.new(users, current_user: current_user).serializable_hash.to_json
    render json: render_json
  end
end
