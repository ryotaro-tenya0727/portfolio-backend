Aws.config.update({
    region: 'ap-northeast-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})

Signer = Aws::S3::Presigner.new
