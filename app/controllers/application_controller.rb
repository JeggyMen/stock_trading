class ApplicationController < ActionController::Base
  before_action :authenticate_user!
    def after_sign_in_path_for(resource)
      if resource.admin?
        admin_authenticated_root_path
      else
        client_dashboard_path 
      end
    end
  end