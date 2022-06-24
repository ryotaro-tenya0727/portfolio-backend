class Api::V1::DiariesController < ApplicationController
  def index
    diaries = Diary.all.published.preload(:diary_images).eager_load(:recommended_member,:user).order(event_date: :desc)
    render_json = DiaryListSerializer.new(diaries).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def show
    diary = Diary.find_by(uuid: params[:uuid])
    render_json = DiaryListSerializer.new(diary).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
