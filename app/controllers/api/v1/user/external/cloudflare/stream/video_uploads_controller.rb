module Api
  module V1
    module User
      module External
        module Cloudflare
          module Stream
            class VideoUploadsController < ApplicationController

              def create
                authorize(%i[user external cloudflare stream video_upload], :create?)
                client = Api::Client.new(
                                          url: ENV['CLOUDFLARE_STREAM_API_URL'],
                                          body:{url: "https://d3mm4dcnbm0rgc.cloudfront.net/development_videos/2326/diary/3a1394f0-3dbc-49bd-85ec-ec6bf80d10a1.mov"},
                                          headers: { authorization_token: ENV['CLOUD_FLARE_VIDEO_STREAM_API_TOKEN'] }
                                        )
                response = client.post
                render json: response, status: :ok
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
