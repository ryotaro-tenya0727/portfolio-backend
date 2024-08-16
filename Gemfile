source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.5'
gem 'rails', '~> 6.1.5'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'redis', '~> 5.1'
# 環境毎に有効/無効を設定するためロードしない
gem 'coverband', require: false

# 環境変数
gem 'dotenv-rails'
# 認証
gem 'jwt'
# 権限管理
gem 'pundit'
# シリアライザー
gem 'jsonapi-serializer'
gem 'bootsnap', '>= 1.4.4', require: false
# cors
gem 'rack-cors'
# aws
gem 'aws-sdk-s3', '~> 1.114'
# 無限スクロール
gem 'kaminari'
# API
gem 'faraday'
gem 'faraday-net_http'

gem 'pusher', '~> 2.0', '>= 2.0.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
  gem 'rspec-rails', '~> 4.1.0'
	gem 'factory_bot_rails'
  gem 'rspec_junit_formatter', '~> 0.5.1'
  gem 'simplecov', require: false, group: :test
  gem 'annotate'
  gem 'awesome_print'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'rubocop', require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'unicorn'
end
