class Api::V1::User::RecommendedMembersController < SecuredController
  before_action :set_recommended_member, only: %i[edit update destroy]

  def index
    authorize([:user, RecommendedMember])
    recommended_members = current_user.recommended_members.all
    render_json = RecommendedMemberSerializer.new(recommended_members).serializable_hash.to_json
    render json: render_json, status: 200
  end

  def create
    authorize([:user, RecommendedMember])
    recommended_member = current_user.recommended_members.create!(recommended_member_params)
    render json: { 'register_member': true }, status: 200
  rescue ActiveRecord::RecordInvalid => e
    render400(e, recommended_member.errors.full_messages)
  end

  def edit
    authorize([:user, @recommended_member])
    render_json = RecommendedMemberSerializer.new(@recommended_member).serializable_hash.to_json
    render json: render_json, status: 200
  end

  def update
    authorize([:user, @recommended_member])
    @recommended_member.update!(recommended_member_params)
    render json: { 'update_member': true }, status: 200
  rescue ActiveRecord::RecordInvalid => e
    render400(e, @recommended_member.errors.full_messages)
  end

  def destroy
    authorize([:user, @recommended_member])
    @recommended_member.destroy!
    # exception handling 500 in concern/api/exception_handler.rb
    render json: { 'destroy_member': true }, status: 200
  end

  private

  def recommended_member_params
    params.require(:recommended_member).permit(:nickname, :group).merge(first_met_date: params[:recommended_member][:first_met_date].to_date)
  end

  def set_recommended_member
    @recommended_member = current_user.recommended_members.find_by!(uuid: params[:uuid])
    # exception handling 404 in concern/api/exception_handler.rb
  end
end
