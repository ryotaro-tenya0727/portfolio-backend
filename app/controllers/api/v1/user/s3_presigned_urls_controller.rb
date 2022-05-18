class Api::V1::User::S3PresignedUrlsController < SecuredController
  def diary_presigned_url
    authorize(%i[user s3_presigned_urls], :diary_presigned_url?)
    presigned_url = Signer.presigned_url(:put_object,
                                         bucket: ENV['S3_BUCKET'],
                                         key: diary_s3_url.to_s)
    render json: { presigned_url: presigned_url, image_url: "#{ENV[CLOUDFRONT_DISTRIBUTION]}/#{diary_s3_url}" }
  end

  private

  def presigned_url_params
    params.require(:presigned_url).permit(:filename)
  end

  def diary_s3_url
    "#{ENV['S3_DIARY_OBJECT_KEY']}/#{current_user.uuid}/diary/#{presigned_url_params[:filename]}"
  end
end
