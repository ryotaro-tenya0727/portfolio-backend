class Api::V1::User::S3PresignedUrlsController < SecuredController
  def diary_presigned_url
    authorize(%i[user s3_presigned_urls], :diary_presigned_url?)
    presigned_url = Signer.presigned_url(:put_object,
                                         bucket: ENV['IMAGE_S3_BUCKET'],
                                         key: diary_s3_url.to_s,
                                         expires_in: 3600)
    render json: { presigned_url: presigned_url, diary_image_url: "#{ENV['IMAGE_CLOUDFRONT_DISTRIBUTION']}/#{diary_s3_url}" }
  end

  private

  def presigned_url_params
    params.require(:presigned_url).permit(:filename)
  end

  def diary_s3_url
    "#{ENV['IMAGE_S3_DIARY_OBJECT_KEY']}/#{current_user.id}/diary/#{presigned_url_params[:filename]}"
  end
end
