class Api::V1::User::TimelineController < SecuredController
  def index
    time_line = current_user.time_line
    render_json = User::DiaryListSerializer.new(time_line).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
