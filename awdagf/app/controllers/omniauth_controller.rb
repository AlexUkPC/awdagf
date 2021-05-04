class OmniauthController < Devise::RegistrationsController
  def facebook
      @user = User.create_from_provider_data(request.env['omniauth.auth'])
      if @user.persisted?
          sign_in_and_redirect @user
          flash[:alert] = "You are authenticated by Facebook" if is_navigational_format?
      else
          flash[:error] = "There was a problem with FB"
          redirect_to new_user_registration_url
      end
  end
  def google_oauth2
      @user = User.create_from_provider_data(request.env['omniauth.auth'])
      if @user.persisted?
          sign_in_and_redirect @user
          flash[:alert] = "You are authenticated by Google" if is_navigational_format?
      else
          flash[:error] = "There was a problem with Google"
          redirect_to new_user_registration_url
      end
  end
  def failure
      flash[:error] = "There was a problem"
      redirect_to new_user_registration_url 
  end
  private
  def sign_up_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
  def account_update_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password)
  end
end