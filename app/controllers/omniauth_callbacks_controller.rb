class OmniauthCallbacksController <  Devise::OmniauthCallbacksController
  Devise.omniauth_providers.each do |provider|
    define_method(provider) do
      @user = User.find_or_create_by_auth(env["omniauth.auth"], current_user)
      if @user.persisted? 
        sign_in_and_redirect(@user, event: :authentication)
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
      else
        session['devise.omniauth'] = env["omniauth.auth"]
        redirect_to new_user_registration_path
      end
    end
  end
end