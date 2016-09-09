module Api
    module V1
        class SessionsController < Api::ApiController
            respond_to :json

            def create
                unless params[:remember_me].nil?
                    user = find_user(params[:remember_me])
                    if user
                        render json: user, status: 200
                    end
                else            
                    user = User.find_by(email: params[:session][:email].downcase)
                    if user && user.authenticate(params[:session][:password])
                        update_remember_token(user)
                        render json: user, status: 200
                    else
                        render json: {errors: "Invalid email or password"}, status: 401
                    end
                end
            end

            def destroy
                user = find_user(params[:id])
                update_remember_token(user)
                head 204
            end

            private
            def find_user(remember_token)
                User.all.find_each do |user|
                    if BCrypt::Password.new(user.auth_token).is_password?(remember_token)
                        return user
                    end   
                end
            end
        end
    end
end
