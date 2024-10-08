class Admin::DashboardsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
  
    def index
        @traders = User.trader.where(approved: true)
    end
  
    private
  
    def authorize_admin!
      redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
    end
  end