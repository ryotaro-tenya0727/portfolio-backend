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
                  # presigned_url = S3::PresignedUrlService.new(current_user).presigned_url
                  # render json: { presigned_url: presigned_url }, status: :ok
                end
              end
            end
          end
        end
      end
    end
  end
end
