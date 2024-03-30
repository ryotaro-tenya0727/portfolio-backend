module Api
  module V1
    module User
      module External
        module Aws
          module S3
            module PresignedUrl
              class ProfilesController < SecuredController
                def create
                  authorize(%i[user external aws s3 presigned_url profile], :create?)
                  presigned_url = Signer.presigned_url(:put_object,
                                                      bucket: ENV['IMAGE_S3_BUCKET'],
                                                      key: profile_image_s3_url.to_s,
                                                      expires_in: 3600)
                  render json: { presigned_url: presigned_url, diary_image_url: "#{ENV['IMAGE_CLOUDFRONT_DISTRIBUTION']}/#{profile_image_s3_url}" }
                end

                private

                def presigned_url_params
                  params.require(:presigned_url).permit(:filename)
                end

                def profile_image_s3_url
                  "#{ENV['IMAGE_S3_DIARY_OBJECT_KEY']}/#{current_user.id}/profile/#{presigned_url_params[:filename]}"
                end
              end
            end
          end
        end
      end
    end
  end
end
