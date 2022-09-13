class Api::V1::User::TimelineController < SecuredController
  def index
    time_line = if current_user.nil?
                  Diary.all
                       .page(1)
                       .without_count
                       .preload(:diary_images, :recommended_member, :user)
                       .order(created_at: :desc)
                else
                  current_user.time_line
                end
    render_json = User::TimelineSerializer.new(time_line).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
