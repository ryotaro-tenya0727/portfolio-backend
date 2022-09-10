class Authorization::AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def current_user(name = nil, user_image = nil)
    @auth_payload, @auth_header = verify_token
    @user = User.from_token_payload(@auth_payload, name, user_image)
  end

  private

  def http_token
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  def verify_token
    Authorization::VerifyJwtTokenService.verify(http_token)
  end
end
