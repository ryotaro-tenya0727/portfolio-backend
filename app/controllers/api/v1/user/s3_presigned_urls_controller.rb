class Api::V1::User::S3PresignedUrlsController < SecuredController
  def diary_presigned_url
    authorize(%i[user s3_presigned_urls], :diary_presigned_url?)
    # diary_image = current_user.diary_images.build(diary_image_url: "#{ENV[CLOUDFRONT_DISTRIBUTION]}/#{diary_s3_url}")
    # diary_image.save!
    presigned_url = Signer.presigned_url(:get_object,
                                         bucket: ENV['S3_BUCKET'],
                                         key: diary_s3_url.to_s,
                                         expires_in: 300)
    render json: presigned_url
  rescue ActiveRecord::RecordInvalid => e
    render400(e, diary_image.errors.full_messages)
  end

  private

  def presigned_url_params
    params.require(:presigned_url).permit(:filename)
  end

  def diary_s3_url
    "user/#{current_user.uuid}/diary/#{presigned_url_params[:filename]}"
  end
end
