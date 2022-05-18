class Api::V1::User::RecommendedMembersController < SecuredController
  before_action :set_recommended_member, only: %i[update destroy]

  def index
    authorize([:user, RecommendedMember])
    recommended_members = current_user.recommended_members.all
    render_json = RecommendedMemberSerializer.new(recommended_members).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, RecommendedMember])
    recommended_member = current_user.recommended_members.build(recommended_member_params)
    recommended_member.save!
    head :ok
  rescue ActiveRecord::RecordInvalid => e
    render400(e, recommended_member.errors.full_messages)
  end

  def update
    authorize([:user, @recommended_member])
    @recommended_member.update!(recommended_member_params)
    head :ok
  rescue ActiveRecord::RecordInvalid => e
    render400(e, @recommended_member.errors.full_messages)
  end

  def destroy
    authorize([:user, @recommended_member])
    @recommended_member.destroy!
    head :ok
  rescue ActiveRecord::RecordNotDestroyed => e
    render500(e, @recommended_member.errors.full_messages)
  end

  private

  def recommended_member_params
    params.require(:recommended_member).permit(:nickname, :group, :first_met_date)
  end

  def set_recommended_member
    @recommended_member = current_user.recommended_members.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render404(e, @recommended_member.errors.full_messages)
  end
end
