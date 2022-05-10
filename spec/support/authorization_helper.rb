module AuthorizationHelper
  def registration_stub
    allow_any_instance_of(Api::V1::UsersController).to receive(:register_user).and_return(current_user)
  end

  def registration_exception_stub
    allow_any_instance_of(Api::V1::UsersController).to receive(:register_user).and_raise(JWT::VerificationError)
  end

  def authorization_stub
    allow_any_instance_of(SecuredController).to receive(:authorize_request).and_return(current_user)
    allow_any_instance_of(SecuredController).to receive(:current_user).and_return(current_user)
  end

end
