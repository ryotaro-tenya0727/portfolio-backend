class Api::V1::User::TimelineController < SecuredController
  def index
    if current_user.nil?
      time_line = Diary.all.published.preload(:diary_images, :recommended_member, :user).order(created_at: :desc)
      render_json = User::TimelineSerializer.new(time_line).serializable_hash.to_json
      render json: render_json, status: :ok
    else
      time_line = current_user.time_line
      render_json = User::TimelineSerializer.new(time_line).serializable_hash.to_json
      render json: render_json, status: :ok
    end
  end
end
