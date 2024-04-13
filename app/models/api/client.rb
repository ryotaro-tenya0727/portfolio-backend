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
        request.headers["Content-Type"] = "application/json"
        request.body = @body.to_json
        request.headers['Authorization'] = "Bearer #{token}" if token
      end
      JSON.parse(body)
    end

    def self.test
      client = Api::Client.new(
                                url: ENV['CLOUDFLARE_STREAM_API_URL'],
                                body:{url: "https://idol-project-video.s3.ap-northeast-1.amazonaws.com/development_videos/2326/diary/071e65dd-e203-4412-84d5-cf83d47fd1a2.mov"},
                                headers: { authorization_token: ENV['CLOUD_FLARE_VIDEO_STREAM_API_TOKEN'] }
                              )
      response = client.post
      response.body
    end
  end
end
