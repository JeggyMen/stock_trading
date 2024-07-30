class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admins!

  def dashboard
  end

  def user_form

  end

  def user_create

  end

  private

  def authorize_admins!
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end