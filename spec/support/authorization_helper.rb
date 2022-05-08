module AuthorizationHelper
  def registration_stub
    @user_info = [
      { 'sub' => 'test_sub',
        'name' => 'test_name',
        'role' => 'admin' }
    ]
    allow_any_instance_of(Api::V1::UsersController).to receive(:register_user).and_return(@user_info)
  end

  def registration_exception_stub
    allow_any_instance_of(Api::V1::UsersController).to receive(:register_user).and_raise(JWT::VerificationError)
  end

  def authorization_stub
    allow_any_instance_of(SecuredController).to receive(:authorize_request).and_return(@user_info)
  end
end
