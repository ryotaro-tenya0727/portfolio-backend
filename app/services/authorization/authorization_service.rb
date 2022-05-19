class Authorization::AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def current_user(name, user_image)
    @auth_payload, @auth_header = verify_token
    @user = User.from_token_payload(@auth_payload, name, user_image)
  end

  private

  def http_token
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  def verify_token
    VerifyJwtToken::VerifyJwtTokenService.verify(http_token)
  end
end
