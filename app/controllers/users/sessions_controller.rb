class Users::SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]
  
    # POST /resource/sign_in
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
  
      # Check the role
      if params[:user][:role] != resource.role
        sign_out(resource)
        redirect_to new_user_session_path, alert: 'Invalid role selected for this user.'
      else
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    end
  
    protected
  
    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
    end
end