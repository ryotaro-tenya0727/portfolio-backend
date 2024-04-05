module Api
  module V1
    module User
      class ProfilesController < SecuredController
        def show
          authorize(%i[user profile])
          render json: {
            name: current_user.name,
            user_image: current_user.user_image,
            me_introduction: current_user.me_introduction
          }, status: :ok
        end

        def update
          authorize(%i[user profile])
          current_user.update!(profile_update_params)
          head :no_content
        end

        private

        def profile_update_params
          params.require(:profile).permit(:name, :user_image, :me_introduction)
        end
      end
    end
  end
end
