# 名前空間からmoduleとクラス作成
module Api
  module V1
    module User
      module External
        module Aws
          module S3
            module PresignedUrl
              class DiaryVideosController < SecuredController
                def create
                  authorize(%i[user external aws s3 presigned_url diary_video], :create?)
                  presigned_url = Signer.presigned_url(:put_object,
                                                       bucket: ENV['VIDEO_S3_BUCKET'],
                                                       key: diary_video_s3_url.to_s,
                                                       expires_in: 3600)
                  render json: { presigned_url: presigned_url, diary_video_url: "#{ENV['VIDEO_CLOUDFRONT_DISTRIBUTION']}/#{diary_video_s3_url}" }
                end

                private

                def presigned_url_params
                  params.require(:presigned_url).permit(:filename)
                end

                def diary_video_s3_url
                  "#{ENV['VIDEO_S3_DIARY_OBJECT_KEY']}/#{current_user.id}/diary/#{presigned_url_params[:filename]}"
                end
              end
            end
          end
        end
      end
    end
  end
end
#
# このコードは、AWS S3に対してプリサインドURLを生成するためのコントローラです。
# このコントローラは、日記の動画をアップロードするためのプリサインドURLを生成します。
# このコントローラは、プロフィール画像をアップロードするためのプリサインドURLを生成するコントローラと似ています。
# このコントローラは、プロフィール画像のプリサインドURLを生成するコントローラと似ていますが、
# バケット名とキーの生成方法が異なります。
# このコントローラは、プリサインドURLを生成するためのパラメータを受け取り、
# プリサインドURLを生成し、JSON形式でレス
