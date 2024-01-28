class Api::V1::User::RecommendedMembersController < SecuredController
  before_action :set_recommended_member, only: %i[update destroy show]

  def index
    authorize([:user, RecommendedMember])
    recommended_members = current_user.recommended_members.all.preload(:diaries).order(created_at: :desc)
    render_json = User::RecommendedMembersSerializer.new(recommended_members).serializable_hash.to_json
    # byebug
    # AppPusher.trigger('my-channel', 'my-event', {
    #   message: 'hello world'
    # })

    render json: render_json, status: :ok
  end

  def create
    authorize([:user, RecommendedMember])
    recommended_member = current_user.recommended_members.build(recommended_member_params)
    recommended_member.save!

    head :ok
  end

  def show
    authorize([:user, @recommended_member])
    render_json = User::RecommendedMembersSerializer.new(@recommended_member).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def update
    authorize([:user, @recommended_member])
    @recommended_member.update!(recommended_member_params)
    head :ok
  end

  def destroy
    authorize([:user, @recommended_member])
    @recommended_member.destroy!
    head :ok
  end

  private

  def recommended_member_params
    params.require(:recommended_member).permit(:nickname, :group, :first_met_date)
  end

  def set_recommended_member
    @recommended_member = current_user.recommended_members.find_by!(id: params[:id])
  end
end
