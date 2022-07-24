class Api::V1::DiariesController < ApplicationController
  def index
    diaries = Diary.all.published.preload(:diary_images, :recommended_member, :user).order(created_at: :desc).limit(3)
    render_json = DiaryListSerializer.new(diaries).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def show
    diary = Diary.find_by!(id: params[:id])
    render_json = DiaryDetailSerializer.new(diary).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
