class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_trader!, only: [:index]

  def index
    @transactions = Transaction.for_user(current_user).includes(:stock)
  end

  private

  def authorize_trader!
    redirect_to root_path, alert: 'Not authorized' unless current_user.trader?
  end
end