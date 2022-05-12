class Api::V1::User::DiariesController < ApplicationController
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    authorize([:user, RecommendedMember])
    diaries = current_user.recommended_members.find_by(uuid: params[:uuid]).diaries.all
    render_json = DiaryListSerializer.new(diaries).serializable_hash.to_json
    # exception handling 404 in concern/api/exception_handler.rb
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, RecommendedMember])
    diary = current_user.diaries.build(diary_params)
    diary.save!
    render json: { 'register_diary': true }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render400(e, diary.errors.full_messages)
  end

  def show
    authorize([:user, @diary])
    render_json = DiaryDetailSerializer.new(@diary).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def edit
    authorize([:user, @diary])
    render_json = DiaryDetailSerializer.new(@diary).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def update
    authorize([:user, @diary])
    @diary.update!(diary_update_params)
    render json: { 'update_diary': true }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render400(e, @diary.errors.full_messages)
  end

  def destroy
    authorize([:user, RecommendedMember])
    @diary.destroy!
    # exception handling 500 in concern/api/exception_handler.rb
    render json: { 'destroy_diary': true }, status: :ok
  end

  private

  def diary_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count, :impressive_memory, :impressive_memory_detail, :status).merge(recommended_member_id: params[:recommended_member_id])
  end

  def diary_update_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count, :impressive_memory, :impressive_memory_detail, :status)
  end

  def set_diary
    @diary = current_user.diaries.find_by(uuid: params[:uuid])
    # exception handling 404 in concern/api/exception_handler.rb
  end
end
