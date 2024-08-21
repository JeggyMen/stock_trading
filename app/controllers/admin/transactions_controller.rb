class Admin::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @transactions = Transaction.includes(:user, :stock).all
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
  end
end