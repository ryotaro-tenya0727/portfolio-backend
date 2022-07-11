class Admin::UsersController < SecuredController
  def index
    @users = policy_scope(User, policy_scope_class: Admin::UserPolicy::Scope)
    render_json = Admin::AdminUserSerializer.new(@users)
    render json: render_json, status: :ok
  end

  def destroy
    @user =  User.find(params[:id])
    authorize([:admin, @user])
    @user.destroy!
    head :ok
  end
end
