class Api::V1::User::TimelineController < SecuredController
  def index
    time_line = Diary.all
                     .page(params[:page])
                     .without_count
                     .preload(:diary_images, :recommended_member, :user, :like_users)
                     .order(created_at: :desc)
    render_json = User::TimelineSerializer.new(time_line, current_user: current_user).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def follow
    time_line = current_user.time_line(params[:page])
                            .order(created_at: :desc)
    render_json = User::TimelineSerializer.new(time_line, current_user: current_user).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
