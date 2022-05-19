class Api::V1::User::DiariesController < SecuredController
  before_action :set_diary, only: %i[show update destroy]

  def index
    authorize([:user, Diary])
    diaries = current_user.recommended_members.find_by!(id: params[:recommended_member_id]).diaries.all
    render_json = User::DiaryListSerializer.new(diaries).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, Diary])
    ActiveRecord::Base.transaction do
      diary = current_user.diaries.build(diary_params)
      diary.save!
      diary_image = diary.diary_images.build(diary_image_url: params[:diary][:diary_image_url])
      diary_image.save!
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

  def diary_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count,
                                  :impressive_memory, :impressive_memory_detail, :status).merge(recommended_member_id: params[:recommended_member_id])
  end

  def diary_update_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count,
                                  :impressive_memory, :impressive_memory_detail, :status)
  end

  def set_diary
    @diary = current_user.diaries.find_by!(id: params[:id])
  end
end
