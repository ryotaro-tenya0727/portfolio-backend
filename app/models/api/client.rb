module Api
  class Client
    def initialize(url:, body:, headers: {})
      @url = url
      @body = body
      @headers = headers
      @connection = Faraday.new(url: url)
    end

    attr_reader :url, :body, :headers, :connection

    def post_request
      token = @headers[:authorization_token]
      response = @connection.post do |request|
        request.headers['Content-Type'] = 'application/json'
        request.body = @body.to_json
        request.headers['Authorization'] = "Bearer #{token}" if token
      end
      JSON.parse(response.body)
    end
  end
end
