class Api::V1::User::DiariesController < SecuredController
  before_action :set_diary, only: %i[show update destroy]

  def index
    authorize([:user, Diary])
    diaries = current_user.recommended_members.find_by!(id: params[:recommended_member_id]).diaries.preload(:diary_images).order(created_at: :desc)
    render_json = User::DiaryListSerializer.new(diaries).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, Diary])
    ActiveRecord::Base.transaction do
      diary = current_user.recommended_members.find_by!(id: params[:recommended_member_id]).diaries.build(diary_params)
      diary.save!
      diary.reload
      create_diary_video(diary)
    end
    head :ok
  end

  def show
    authorize([:user, @diary])
    render_json = User::DiaryDetailSerializer.new(@diary).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def update
    authorize([:user, @diary])
    @diary.update!(diary_update_params)
    head :ok
  end

  def destroy
    authorize([:user, @diary])
    @diary.destroy!
    head :ok
  end

  private

  def create_diary_video(diary)
    diary_videos = diary_video_params[:diary_videos].to_h
    if diary_videos.keys.size.positive?
      diary.create_diary_video!(diary_video_params[:diary_videos])
    end
  end

  def diary_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count,
                                  :impressive_memory, :impressive_memory_detail, :status, diary_images_attributes: [:diary_image_url]).merge(user_id: current_user.id)
  end

  def diary_video_params
    params.require(:diary).permit(diary_videos: %i[thumbnail_url video_uid])
  end

  def diary_update_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count,
                                  :impressive_memory, :impressive_memory_detail, :status)
  end

  def set_diary
    @diary = current_user.diaries.find_by!(id: params[:id])
  end
end
