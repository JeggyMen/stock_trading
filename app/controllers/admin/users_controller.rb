class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_user, only: [:show, :edit, :update]
  
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

    def edit
    end

    def update
        if @user.update(user_params)
          flash[:notice] = 'User was successfully updated.'
          redirect_to admin_dashboard_path
        else
          flash[:alert] = 'Failed to update user.'
          render :edit
        end
    end

    def show
    end

  
    private

    def set_user
        @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def authorize_admin!
      redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
    end
end
  