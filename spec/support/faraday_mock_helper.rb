module  FaradayMockHelper
  def define_success_faraday_mock(url, body)
    faraday_test_mock = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post(url) do |env|
          [
            200,
            { 'Content-Type': "application/json", },
            body
          ]
        end
      end
    end
    Faraday::Connection.define_method "post_request" do
      self.post(url).body
    end
    allow(Api::Client).to receive(:new).and_return(faraday_test_mock)
  end
end
