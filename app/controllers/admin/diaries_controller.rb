class Admin::DiariesController < SecuredController
  def index
    user_diaries = User.find(params[:user_id]).diaries.preload(:diary_images).order(event_date: :desc)
    diaries = policy_scope(user_diaries, policy_scope_class: Admin::DiaryPolicy::Scope)
    render_json = Admin::AdminDiarySerializer.new(diaries).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def destroy
    diary = Diary.find(params[:id])
    authorize([:admin, diary])
    diary.destroy!
    head :ok
  end
end
