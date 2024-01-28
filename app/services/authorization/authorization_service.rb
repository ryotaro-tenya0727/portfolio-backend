class Authorization::AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def current_user
    @auth_payload, @auth_header = verify_token
    @user = User.current_user_from_token_payload(@auth_payload)
  end

  def create_user(name, image)
    @auth_payload, @auth_header = verify_token
    @user = User.create_user_from_token_payload(@auth_payload, name, image)
  end

  private

  def http_token
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  def verify_token
    Authorization::VerifyJwtTokenService.verify(http_token)
  end
end
