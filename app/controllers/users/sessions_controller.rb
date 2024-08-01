class Users::SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]
  
    # POST /resource/sign_in
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
  
    # Redirect based on user role
      if resource.role == 'admin'
        redirect_to admin_authenticated_root_path
      else
        redirect_to client_dashboard_path
      end
    end
    protected
  
    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
    end
end