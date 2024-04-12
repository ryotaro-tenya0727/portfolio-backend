module Api
  class Client
    def initialize(url:, params:, headers: {})
      @url = url
      @headers = headers
      @connection = Faraday.new(url: url)
    end

    def post
      token = @headers[:authorization_token]
      @connection.post do |req|
        request.params = params
        request.headers['Authorization'] = "Bearer #{token}"
      end
    end
  end
end
