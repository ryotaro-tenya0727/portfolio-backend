if defined? Coverband
  Coverband.configure do |config|
    if Rails.env.development?
      Dotenv::Railtie.load
    end
    config.store = Coverband::Adapters::RedisStore.new(Redis.new(url: ENV['REDIS_URL']))
    config.logger = Rails.logger

    # 計測対象から外したいファイルを指定
    config.ignore +=  [
      'config/application.rb',
    ]
    config.background_reporting_sleep_seconds = 30
    config.password = ENV['COVERBAND_PASSWORD']
  end
end
