
class CallbacksController < Devise::OmniauthCallbacksController
    def github
        @user = User.from_omniauth(auth_hash)
        sign_in_and_redirect @user
    end
    
    def facebook
        # code
    end
    
    def twitter
        # code
    end
    
    private
    
    def auth_hash
        request.env["omniauth.auth"]
    end
end
