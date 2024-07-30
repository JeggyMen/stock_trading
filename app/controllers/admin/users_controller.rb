class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      @user.role = 'trader' 
      if @user.save
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def authorize_admin!
      redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
    end
  end
  