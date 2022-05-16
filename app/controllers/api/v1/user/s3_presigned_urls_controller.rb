class Api::V1::User::S3PresignedUrlsController < SecuredController
  def diary_presigned_url
    Signer.presigned_url(:get_object,
                          bucket: ENV['S3_BUCKET'],
                          key: "user/#{current_user.uuid}/diary/"
                          expires_in: 300
    )
  end
end
