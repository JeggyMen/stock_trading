class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_user, only: [:show, :edit, :update , :approve  ]
  
    def dashboard
      @pending_traders = User.where(role: 'trader', approved: false)
    end

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      @user.role = 'trader' 
      @user.approved = false
      if @user.save
        redirect_to admin_authenticated_root_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:notice] = 'Trader was successfully updated.'
        redirect_to admin_authenticated_root_path
      else
        render :edit
      end
    end

    def show
    end


    def approve
      if @user.update(approved: true)
        redirect_to admin_authenticated_root_path, notice: 'Trader was successfully approved.'
      else
        redirect_to admin_authenticated_root_path, alert: 'Failed to approve trader.'
      end
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
  