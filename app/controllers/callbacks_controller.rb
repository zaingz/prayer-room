class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @user.username = request.env["omniauth.auth"].info.name
        if @user.save
        	sign_in_and_redirect @user
        end
    end

    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @user.username = request.env["omniauth.auth"].info.name
        if @user.save
	        sign_in_and_redirect @user
	    end
    end
end
