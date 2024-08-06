class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'admin'
      redirect_to admin_authenticated_root_path
    elsif current_user.role == 'trader'
      if current_user.approved
        redirect_to client_dashboard_path
      else
        redirect_to pending_approval_path
      end
    else
      # Handle other roles or unauthenticated users if needed
      redirect_to root_path # or another appropriate path
    end
  end
end