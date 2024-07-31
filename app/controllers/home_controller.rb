class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'admin'
      redirect_to admin_authenticated_root_path
    else
      redirect_to client_dashboard_path
    end
  end
end