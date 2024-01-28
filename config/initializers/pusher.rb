use_tls = Rails.env.development? ? false : true
AppPusher  = Pusher::Client.new(
  app_id: ENV['PUSHER_APP_ID'],
  key: ENV['PUSHER_KEY'],
  secret: ENV['PUSHER_SECRET'],
  cluster: ENV['PUSHER_CLUSTER'],
  use_tls: use_tls
)
