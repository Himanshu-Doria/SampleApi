module Api
    module V1
        class UsersController < Api::ApiController
            respond_to :json

            def create
                user = User.new(user_params)
                if user.save
                    render json: user, status: 201, location: [:api,user]
                else
                render json: {errors: user.errors}, status: 422
                end
            end

            def show
                respond_with User.find(params[:id])                
            end

            def update
                user = User.find(params[:id])
                if user.update(update_user_params)
                    render json: user,serializer: UpdateUserSerializer,root: :user,status: 200, location: [:api,user]
                else
                    render json: {errors: user.errors}, status: 422
                end
            end

            def destroy
                user = User.find(params[:id])
                if user
                    user.destroy
                    head 204
                else
                    render json: {errors: "Not Found"}, status: 404
                end
            end

            private

            def user_params
                params.require(:user).permit(:email,:password,:password_confirmation)
            end

            def update_user_params
                params.require(:user).permit(:email,:password,:password_confirmation,:name,:age,:phone,:address)
            end 
        end
    end        
end