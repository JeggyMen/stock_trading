class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
  
    protected
  
   
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
        devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end
  
   
    def sign_up_parameters
      parameters.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
  end
  