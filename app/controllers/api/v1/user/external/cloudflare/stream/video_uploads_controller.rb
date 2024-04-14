module Api
  module V1
    module User
      module External
        module Cloudflare
          module Stream
            class VideoUploadsController < SecuredController
              def create
                authorize(%i[user external cloudflare stream video_upload], :create?)
                client = Api::Client.new(
                  url: ENV['CLOUDFLARE_STREAM_API_URL'],
                  body: { url: video_upload_params[:url] },
                  headers: { authorization_token: ENV['CLOUD_FLARE_VIDEO_STREAM_API_TOKEN'] }
                  )
                response = client.post_request
                render json: { video_uid: response['result']['uid'], thumbnail_url: response['result']['thumbnail'] }, status: :ok
              end

              def video_upload_params
                params.require(:video_upload).permit(:url)
              end
            end
          end
        end
      end
    end
  end
end
