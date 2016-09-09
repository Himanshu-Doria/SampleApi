module Api
    class ApiController < ApplicationController
        protect_from_forgery with: :null_session

        protected

        def update_remember_token(user)
            user.generate_auth_token
        end
    end
end